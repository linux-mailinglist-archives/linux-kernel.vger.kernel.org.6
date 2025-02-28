Return-Path: <linux-kernel+bounces-537857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB4A491D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672721892F00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD41C2DB4;
	Fri, 28 Feb 2025 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qu3ymKw1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D50748F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726099; cv=none; b=qKXhzLqQnAmJdMDkFdiK95CUWLU/H0nS52dMQVW/C3H02bfJKdowsdm9Gv4eb6jTNe5XAqOl1qgpHN9L3DLGL6I+67otyl+tJfw6QlTZXbsC2zbnLfG/v5Ecmg4ENn67nFCAJsCGXOs0b2OkC/NdN3yXXLJkTTBz/egCkQ4VdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726099; c=relaxed/simple;
	bh=gR7yPP4wQOXRbuQkQwsELeD7rvmiCHvsdcIf94ru7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr8uj7WXtPgm/X2dPSmMJ4FmX0zzbh4Tj/9DETf0l7KlvqVx5zfD4Vv0dVp60gqh3PTOXxsQGe8OxHFqU6HF9xxpDK2laXD7SEBA9E0+pKpTJ5F9ER947Y+xTEft9k6fvSFu9hicXWSS1UWN6LW95irOJB05wwVSv3uP8kpjvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qu3ymKw1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740726083;
	bh=gR7yPP4wQOXRbuQkQwsELeD7rvmiCHvsdcIf94ru7nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu3ymKw1E01gqOz1hkyBoArbLobusETPDti636U/nqQhmTwzk2Nk9CyRJnjUrZFG1
	 nb0vYddCavynLbM3zKxR512kz2VnCNQiUrHX0rCBoOkd+LjvJsw2xkpwd7Mo7oBEIW
	 mBY+MpvDAxCcahZHIHO9HyxqRJthw4Fy535mR1EA=
Date: Fri, 28 Feb 2025 08:01:22 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Dietzer <git@doridian.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add Framework 16 panel
Message-ID: <3aba0b5f-f6fc-4df1-adb4-b4cbad0379f7@t-8ch.de>
References: <1c96811e-4d54-480a-bc09-bcd2999e8e66@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c96811e-4d54-480a-bc09-bcd2999e8e66@app.fastmail.com>

Hi Mark!

On 2025-02-27 18:40:12-0800, Mark Dietzer wrote:
> Similarly for the Framework 13 panels already handled in those quirks, the 16 can be helped by the same kind of patch.
> 
> I have run this on my own 16 for multiple months (hard coding the value to 0 before the quirks made it upstream) and it has resulted in a darker minimum brightness (as expected) and no issues.
> 
> The Framework community threads between the 13 and 16 for this improvement are the same one, so user reports in the link below will be mixed and likely more focused on the 13.
> 
> Link: https://community.frame.work/t/solved-even-lower-screen-brightness/25711/60

The patch itself looks good, so:
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

However there are a few process issues:

* Commit message should be wrapped to 75 characters.
* Signed-off-by is missing
* The patch is not sent to the maintainers, so it will most likely be
  overlooked.

Please use scripts/get_maintainer.pl and scripts/checkpatch.pl to fix up
these issues (or b4 for the whole process handling).
Then add my Reviewed-by tag and resend the patch with a "v2" marker.

In case of any questions let me know.
Feel free to also send your patch to me privately to check the
formalities.


Thomas

> ---
>  drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index c477d98ade2b..52aa2a7fa63e 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -41,6 +41,14 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
>                 .ident.name = "NE135A1M-NY1",
>                 .min_brightness = 0,
>         },
> +       /* 16 inch panel */
> +       {
> +               .dmi_match.field = DMI_BOARD_VENDOR,
> +               .dmi_match.value = "Framework",
> +               .ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
> +               .ident.name = "NE160QDM-NZ6",
> +               .min_brightness = 0,
> +       },
>  };
> 
>  static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
> --
> 2.48.1

