Return-Path: <linux-kernel+bounces-422354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7249D9890
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5159B231FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD9D53C;
	Tue, 26 Nov 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jH9q2gfp"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469598BEA;
	Tue, 26 Nov 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627865; cv=none; b=QyI2qy3GcASgfFOAyFSVu1rrNBAiu2TlFlGsuzfF95oCY/u7RJREKSwVq7q0CQ59SyhSyCFDwI21b/5zhj56lDg/IQdmYqDenoIhEzvoEJ4+GE8XiAphQ/DcgBCL14fbPwwlUVXZO64d/Wo+9QsRi5Y+sd2g6dInGaCbEf//5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627865; c=relaxed/simple;
	bh=CccEfDRGiSlzDQMOUSR0Q1xEFwiDs6uwvHLGjX8YuWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfsa0HqEg7Wza55eBYeCzYxTH8La1pHA+27vNMuCYcAmfyzY7Dx3+TwD1J4rx1LDxGuzD/trQ0FFPbwGr058m5oXns85AdvPz0ZdeEI6zKEV5ia3BMfQhajmpW2Jro8CnWy+GjhL3ZdEWTN2VR56PW7b23ZqDOaojF/EvkhJCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jH9q2gfp; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=BAOgYh5j+SwhH6if2YDkf+cLk18YFHVIqBQI2gqekAg=; b=jH9q2g
	fpav4/Xv0+OPZFBUl80Ui6EaVsSTNnRONJnzH8v2l98vyBaMIz8KF8gGtlXxGatJEWN/Aqt65O4PF
	kDVlk4qu6t2uggymvlx6V9TM1JQ62SDkaN8dcWEVd2c/tDzC1GKShrpCRzE52rj4W1lUvL/XlTNqz
	7t+dlP4I/2lv+CweUmGrhdNxYn+yWNBrKnMxWjEncChobYMmYh9TeWZ2u/86geXxbrP57peTGDZih
	V1R3V5SqHRwvcZ25izIkFIfmCrNrGKe++E0PhMtJdNHPG927Qt/TRbs5axJ5xCiycV2fE+nq1I+N2
	J2lN9BwRaCost6IjzKjr0pHUQ9Sw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tFveZ-0007CU-RO; Tue, 26 Nov 2024 14:30:55 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tFveY-0003aF-26;
	Tue, 26 Nov 2024 14:30:54 +0100
Date: Tue, 26 Nov 2024 14:30:53 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
Message-ID: <tzcjzgp7xalhhezcv5hfa7cjscxg44phqcw2ap54lesly4gk6o@6dtco2d3jahj>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27469/Tue Nov 26 10:58:20 2024)

Hi Maxime,

On Tue, Nov 26, 2024 at 08:36:01AM +0100, Sean Nyekjaer wrote:
> Hi Maxime,
> 

[...]

> > 
> > We probably need some kunit tests here too.
> 
> Good idea, will be my first :)
> 

Would something like this work?

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 294773342e71..26e4ff02df85 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -1364,6 +1364,7 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
+	enum drm_mode_status mode_status;
 	unsigned long long rate;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -1408,6 +1409,9 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	mode_status = drm_mode_check_pixel_clock(preferred, rate);
+	KUNIT_ASSERT_EQ(test, mode_status, MODE_OK);
+
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);

/Sean

