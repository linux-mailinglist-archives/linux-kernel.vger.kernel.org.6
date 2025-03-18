Return-Path: <linux-kernel+bounces-565795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A143A66F45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ED7421FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E82054F2;
	Tue, 18 Mar 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhtjsBNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078671F5842
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288779; cv=none; b=jE95qRSiBRCPM09jJyZZqYTdmtHMuWRM+GLDz2mqyzawK+v6LOkSkGwbk7fG01ZxgwsP58HZ8EmMs0IrXzNUYUUNbllwIigGmX3s9G3TIF1FIpPwUg6XARIaCgRVSC28RGgTDUMcf7Q+8mT3RuLfrXKPoZPadSxCSHPqVzEk4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288779; c=relaxed/simple;
	bh=MEbMt30gtbDW29ZsyHH0TxtnC6VxqGi8GZrrw0ikjR0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=BK8082Wvt8OypmtJZhqLA5LWKlS9NRit0FLh5klbeYX9e9sOSnGRT0asZVnRSKtfbOLAYgrF1fcVNd4YtAATC+5+bjNvBTtIk1X71AlpDAIDN3CNZuiMd7JULC5m7Thdm92iY08B2AIuVXkSNQ3VQy8jvt9qkEP+CbX9r9Pkfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhtjsBNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194C1C4CEDD;
	Tue, 18 Mar 2025 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742288777;
	bh=MEbMt30gtbDW29ZsyHH0TxtnC6VxqGi8GZrrw0ikjR0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=UhtjsBNy+l6eFX+9Xjkck/otCYCinjjW4SYdOdH9fdpA2q9LcxlQsqYNsC/u00YIR
	 zeWMPJmv5rUdmK/A6xncB4DEqgVlh5qnYlipkEFO5/9Rqss5FB/daspzL093bgTteG
	 AAyoHnwo781YS0O1CUjQzRXU+FcwwSELsqI4pg9LJUbX9yjxs/nBzdzaxXGN4L9WDp
	 mtJFYZglA00043Q3rM83Jv4jVo4gfGaC1N8zBe96X1FY8968tcmx42Xf2iCrf+2FFk
	 o0TpP+CEYmatqERQkvtLkc60t1NUuYJ7SwQBldHzlTYew7rZ0rV5RabF4HHjhl+/Lt
	 rr3xlZNrOhvlw==
Message-ID: <231da63e5d9b570aad31e524ee22784c@kernel.org>
Date: Tue, 18 Mar 2025 09:06:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "David Turner" <david.turner@raspberrypi.com>
Subject: Re: [PATCH v4 1/3] drm/display: Update comment on hdmi hotplug
 helper
In-Reply-To: <20250317-vc4_hotplug-v4-1-2af625629186@raspberrypi.com>
References: <20250317-vc4_hotplug-v4-1-2af625629186@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 17 Mar 2025 17:12:22 +0000, David Turner wrote:
> Update the comment on drm_atomic_helper_connector_hdmi_hotplug() to
> clarify that it must be called for all status updates.
> 
> Signed-off-by: David Turner <david.turner@raspberrypi.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

