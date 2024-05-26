Return-Path: <linux-kernel+bounces-189751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754D8CF481
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9551B20CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A19171CC;
	Sun, 26 May 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e36w4Xbu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rdcm6R9B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D61D534
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716733864; cv=none; b=ghpCC8v19dadT1Upc7auFDLV6m4i+ZYyQBXaZhKsqzOIlOQqk5Esxq/q0GqkctNZx2bMMdaZuTtkrnkUB1PKraXC5O2XDrKzgj/LP38NB/kNQlYwL26o3WbPe8gMbJGGyU04UUU9QPxBZb5wWFd8Qf1FnXiG9YNsWs+qxg7LuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716733864; c=relaxed/simple;
	bh=GztFcP8ReuyEBq22Bavh1nCcM/HA12Jpwj7ouvRvTOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni5Jv/36+t/LerjimXN9VD1QsOP7NKGUQjSQawG+AgepT8TWAHnTC/Aw5aibPBXJQCJgiIVbhxmf+69Fsl61ayTyS/pj0aP+j78WQ7NbP9VV4rs4ZrQ1xVcGMXH8K+J2epuOHCL2gfGy1HjMYiLShbUeEg4ShkShS8FSnK5lAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e36w4Xbu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rdcm6R9B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 26 May 2024 16:31:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716733861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hfLHXUSmV0OIK5d8efxFE2fuJzOP3P7TYV7a9MORL6A=;
	b=e36w4XbuoYSsQAZMzY/UrVy+pQCdMLPISsipTirmICt2ITfJqVLeUWrVmLN3h8NPC4ME/t
	nnaStfeGTi0u8NVswV5qSxewWlB7L9gOAoNXHPnxm+5S/VBj7g6dVCZczmasQIHl7PCkXq
	wybPjNxJezFrGk9saMC2xJ4ChT23y1oe/n+P7hTHS826zMLc3WCkMKiigJU2js3VTVIFdn
	BKSH0TY+tuXibb7myCMuSoYeVI8pEKc+AOZ1KY8lVMaFTSQuMaz4DzUNR/h/PGdYHcvxZw
	92a9TWRZbqYFfK3Gd4CQqZeA0BMWR4+BGrHrWU4hYAHBaLKWanNebZYa32Rt1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716733861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hfLHXUSmV0OIK5d8efxFE2fuJzOP3P7TYV7a9MORL6A=;
	b=Rdcm6R9BUePEEOfPrkzxu3h44FwZyombsqMy/lGJM5rdMIGIEBB8uq7yRV5ElKO8jXg4VP
	QnFJbbYjRSgzt0AA==
From: Nam Cao <namcao@linutronix.de>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8192e: remove dead code
Message-ID: <20240526143100.FmVupNWq@linutronix.de>
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-4-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526111928.14574-4-straube.linux@gmail.com>

On Sun, May 26, 2024 at 01:19:28PM +0200, Michael Straube wrote:
> Remove two else-if arms that do nothing.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 5392d2daf870..4e03eb100175 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -1370,9 +1370,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>  					tmp_sec_rssi = cur_rf_rssi;
>  					sec_rssi_index = i;
>  				}
> -			} else if ((cur_rf_rssi < tmp_sec_rssi) &&
> -					(cur_rf_rssi > tmp_min_rssi)) {
> -				;
>  			} else if (cur_rf_rssi == tmp_min_rssi) {
>  				if (tmp_sec_rssi == tmp_min_rssi) {
>  					tmp_min_rssi = cur_rf_rssi;
> @@ -1426,9 +1423,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>  						tmp_cck_sec_pwdb = cur_cck_pwdb;
>  						cck_rx_ver2_sec_index = i;
>  					}
> -				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
> -						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
> -					;
>  				} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
>  					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
>  						tmp_cck_min_pwdb = cur_cck_pwdb;

I would be careful with these changes. These else-if do prevent the
execution of the other else-if, so the code do not behave the same anymore.

The only case this patch doesn't change anything functionally is when the
condition of the removed if-else is mutually exclusive with the conditions
of the following if-else. Are you sure this is the case?

Best regards,
Nam

