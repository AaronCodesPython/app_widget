package com.flutterjunction.homescreen_widget   // your package name
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider


class HomeScreenWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                println("reached");
                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                //println("ABCDE ${widgetData.getFloat("yearsLeft", 20)}");
                //val yearsLeft =  0.0f;
                val yearsLeft = widgetData.getString("yearsLeft","...");
               
                var yearsLeftText = "value2 is: $yearsLeft"
                println("All SharedPreferences: ${widgetData.getAll()}")
                

                setTextViewText(R.id.tv_yearsLeft, yearsLeftText)
                //setTextViewText(150, "120lol")


                // Pending intent to update counter on button click
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myAppWidget://updateyearsLeft"))
                //setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
