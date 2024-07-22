Return-Path: <linux-kernel+bounces-258603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB8938A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF69B21902
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878711607AA;
	Mon, 22 Jul 2024 07:48:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40E15FCE7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634532; cv=none; b=LpWGBbOZcqz+P5AsZavKNXVe40Nmbe1VoAHHXY8PRr4CLc7I5/i95kG9Uza8xXg3XHjrLiB8IzlN/dJND5M15PdP/pB1LTTZ3bGrY/ZgEtCNBBPVai87wTR8cnC73PgNm52B2acBcCl6VEQ/JA9ffc8UChSCDNkwUN9AK7g9spY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634532; c=relaxed/simple;
	bh=/qnBjbfCUh1+/1JcDHmjjr91H9zM1rgcNsV5mqa1YZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMjjNfDlGq0Il9KNSGbOuYOgKP4fpclRzEdKgu5HmL6baClGLp9pwcWm4sPHaZZn3UpYAeNU/XCX5rAztGTy9I9Tt9PK7Lx7FYGntxaTtpQVtS4I0ib++xORp+7kwjVC9q/Ct+87Y+0uQWZ7FHP8A6P/JObMKsUA31YrKfGhDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mtr@pengutronix.de>)
	id 1sVnmg-00052o-PA; Mon, 22 Jul 2024 09:48:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mtr@pengutronix.de>)
	id 1sVnmg-001KgQ-6H; Mon, 22 Jul 2024 09:48:38 +0200
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mtr@pengutronix.de>)
	id 1sVnmg-00BUPp-0F;
	Mon, 22 Jul 2024 09:48:38 +0200
Date: Mon, 22 Jul 2024 09:48:38 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: platform: allegro-dvt: Constify struct
 regmap_config
Message-ID: <Zp4O1tomRx42sD9o@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240705-media-const-regmap_config-v1-0-56881442bb30@gmail.com>
 <20240705-media-const-regmap_config-v1-2-56881442bb30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705-media-const-regmap_config-v1-2-56881442bb30@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, 05 Jul 2024 12:53:51 +0200, Javier Carrasco wrote:
> `allegro_regmap_config` and `allegro_sram_config` are not modified and
> can be declared as const to move their data to a read-only section.

Christophe sent a similar patch [0] before, which already has my
Reviewed-by.

Michael

[0[ https://lore.kernel.org/linux-media/01b9b16b2f86f4d16d9871a29dcda9245512a1f7.1714894086.git.christophe.jaillet@wanadoo.fr/

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/media/platform/allegro-dvt/allegro-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/media/platform/allegro-dvt/allegro-core.c
> index da61f9beb6b4..1a19fef62e81 100644
> --- a/drivers/media/platform/allegro-dvt/allegro-core.c
> +++ b/drivers/media/platform/allegro-dvt/allegro-core.c
> @@ -179,7 +179,7 @@ struct allegro_dev {
>  	struct list_head channels;
>  };
>  
> -static struct regmap_config allegro_regmap_config = {
> +static const struct regmap_config allegro_regmap_config = {
>  	.name = "regmap",
>  	.reg_bits = 32,
>  	.val_bits = 32,
> @@ -188,7 +188,7 @@ static struct regmap_config allegro_regmap_config = {
>  	.cache_type = REGCACHE_NONE,
>  };
>  
> -static struct regmap_config allegro_sram_config = {
> +static const struct regmap_config allegro_sram_config = {
>  	.name = "sram",
>  	.reg_bits = 32,
>  	.val_bits = 32,
> 
> -- 
> 2.40.1
> 
> 

