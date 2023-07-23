package com.example.native_ads

import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class SquareNativeAdFactory(
    private var layoutInflater: LayoutInflater
) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd?,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.square_native_ad, null) as NativeAdView

        adView.mediaView = adView.findViewById(R.id.square_ad_media)
        adView.mediaView?.mediaContent = nativeAd?.mediaContent

        adView.callToActionView = adView.findViewById(R.id.square_ads_view_cta)
        if (nativeAd?.callToAction == null) {
            adView.callToActionView?.visibility = View.INVISIBLE
        } else {
            adView.callToActionView?.visibility = View.VISIBLE
            (adView.callToActionView as Button).text = nativeAd.callToAction
        }

        adView.iconView = adView.findViewById(R.id.square_ad_app_icon)
        if (nativeAd?.icon == null) {
            adView.iconView?.visibility = View.GONE
        } else {
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon!!.drawable)
            adView.iconView?.visibility = View.VISIBLE
        }

        adView.headlineView = adView.findViewById(R.id.square_ad_headline)
        (adView.headlineView as TextView).text = nativeAd?.headline

        if (nativeAd != null) {
            adView.setNativeAd(nativeAd)
        }
        return adView
    }
}