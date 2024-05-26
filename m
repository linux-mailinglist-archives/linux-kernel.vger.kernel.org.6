Return-Path: <linux-kernel+bounces-189752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A308CF483
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AB32813C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E5171CC;
	Sun, 26 May 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByHYsSYE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hI8HtTao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3582D534
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734027; cv=none; b=fbO36277leSEo65y05s+AzlRF70WQ8q6noorsV6mbFxZae1HttkVU/6Vk63hpTy/AmSoGPdiYrG8ohLGDMXF+erAYuEpiBnN0vZRnh2HUdf/J21MVo9Z3HPW/0qTOvwFccNGAjGqluFMrh8ht9/N2IKORUeUR6gEr4REp8uKL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734027; c=relaxed/simple;
	bh=QA0dpRGMhYJPQHPub7gg3sxVHBbUEmvxO/7j2q05/bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0O7PuTL1EH81+2AyVpz1gJqQ/L5LmYbCIXCEWOfab1Asm/Ur5A5bPxonobYxBssB4++s7oggW8zMGr0MRqrjfwdgGI8FEeZgFxe4dU0eiBSVzfN520LVZs53McjRWS2SPUk/QmsILXEsLvc5bLmLUWD9Rc1dB7Lod4lcbPGvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByHYsSYE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hI8HtTao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 26 May 2024 16:33:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716734023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXGpB/omnYIn3jauojGC79gVRJe/9Up/TN/TGtNhfpY=;
	b=ByHYsSYE5tuKjQwJK38UEN8eieTg5f3+UTMYoJk+nPHiHyswtdsQy6i0kGbTIuNwO5y0Xt
	rhWnTcQgFT4U5r1SdrgIxy/I57nRQH0FtAvxGWUcMpSbfeJOXWX7qdTRLtKq08CNQDj4UB
	1UHT0vlmqsQWJB7tIcWqSkghxL5DNaAyPy3rJjcNQeo5FFApWx7Mo1pjYGcHKQnRf4jUoO
	8H4ArKrc+gvgtoGe2MDmFkGDOrgal9vfeTBvHk5zsFZJdLe6funqh11zTnoPj16+MkaxmJ
	ApOvJhlzvT0nO2+4HO5pPdxWPAVJbX5O8/zrHtOMBQH+UF4HLR+gXZsGXRsNmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716734023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXGpB/omnYIn3jauojGC79gVRJe/9Up/TN/TGtNhfpY=;
	b=hI8HtTaoVnbK2qYoSmRcFsV7t5186FubjTtHnGJ0z4Zzh6XYvDr1/e3SqPwce5iH64pzGl
	QdTR9Xg0dPFYcyBQ==
From: Nam Cao <namcao@linutronix.de>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8192e: remove unnecessary line breaks
Message-ID: <20240526143342.tPBauUTi@linutronix.de>
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-3-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526111928.14574-3-straube.linux@gmail.com>

On Sun, May 26, 2024 at 01:19:27PM +0200, Michael Straube wrote:
> Remove some unnecessary line breaks after '=' and '==' to improve
> readability.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 ++++++++--------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 2fda44c5a412..5392d2daf870 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -1392,8 +1392,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>  				continue;
>  
>  			rf_num++;
> -			cur_cck_pwdb =
> -					dm_rx_path_sel_table.cck_pwdb_sta[i];
> +			cur_cck_pwdb = dm_rx_path_sel_table.cck_pwdb_sta[i];
>  
>  			if (rf_num == 1) {
>  				cck_rx_ver2_max_index = i;
> @@ -1412,27 +1411,20 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>  				}
>  			} else {
>  				if (cur_cck_pwdb > tmp_cck_max_pwdb) {
> -					tmp_cck_sec_pwdb =
> -							tmp_cck_max_pwdb;
> -					cck_rx_ver2_sec_index =
> -							cck_rx_ver2_max_index;
> +					tmp_cck_sec_pwdb = tmp_cck_max_pwdb;
> +					cck_rx_ver2_sec_index = cck_rx_ver2_max_index;
>  					tmp_cck_max_pwdb = cur_cck_pwdb;
>  					cck_rx_ver2_max_index = i;
> -				} else if (cur_cck_pwdb ==
> -						tmp_cck_max_pwdb) {
> +				} else if (cur_cck_pwdb == tmp_cck_max_pwdb) {
>  					tmp_cck_sec_pwdb = cur_cck_pwdb;
>  					cck_rx_ver2_sec_index = i;
>  				} else if (PWDB_IN_RANGE) {
>  					tmp_cck_sec_pwdb = cur_cck_pwdb;
>  					cck_rx_ver2_sec_index = i;
> -				} else if (cur_cck_pwdb ==
> -						tmp_cck_sec_pwdb) {
> -					if (tmp_cck_sec_pwdb ==
> -						tmp_cck_min_pwdb) {
> -						tmp_cck_sec_pwdb =
> -								cur_cck_pwdb;
> -						cck_rx_ver2_sec_index =
> -								i;
> +				} else if (cur_cck_pwdb == tmp_cck_sec_pwdb) {
> +					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb) {
> +						tmp_cck_sec_pwdb = cur_cck_pwdb;
> +						cck_rx_ver2_sec_index = i;
>  					}
>  				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
>  						(cur_cck_pwdb > tmp_cck_min_pwdb)) {

Reviewed-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

