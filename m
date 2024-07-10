Return-Path: <linux-kernel+bounces-248347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50992DBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF6B1C23B82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8514A0B2;
	Wed, 10 Jul 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6k6ujZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62302848E;
	Wed, 10 Jul 2024 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650888; cv=none; b=JwuRLOntg0J+3uP/p/7etyOfdiper57a3wY+fP4bcjv6gJcjlRZ40hYilRBoaVg5gyYJjxs1Zjjmt77xKwzfEpNx40ZwHtumo0TKqc0bVeqpP+Vgdr9jsrcpCQVOzDqgOxQcXFRIx9MsL0p9XPn/Bn9am0b7DYoHx72KPBmWAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650888; c=relaxed/simple;
	bh=HYCH07DJRn0g9/T/c4ky/ALqDjbwGIKesbT6TTrlvrE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZlnlyxZViZU0JbaVLa0Emya0faMSqOL5RyAhZXWPWnnEzyqAy7xs+TVaKO3iQkFyJJiPisZGXwi39tMEczZBu6DDZS6Sg4rHMV8+JjlrXzlW+dCQYh3x2YHBhv9qpGzPsLMhvmGT0iYOfBnypfwQddh4DeThiVpmbL8fLD8D3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6k6ujZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5BEC4AF09;
	Wed, 10 Jul 2024 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720650887;
	bh=HYCH07DJRn0g9/T/c4ky/ALqDjbwGIKesbT6TTrlvrE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=g6k6ujZRyWx3gPwuJSaRxYXQ54a0RKSrxCqIThBk5FSraoSk7RBurJgpfI3uRUvEU
	 VLllZ6YBWBWdZizlxAtOoJui8Av7S+za2woikoHWPD4Hr5u4d4RX1OxfMdLsOSbJVR
	 aLTz6igs7fCXwh5bjECNI/Lki8IAX3QZPx1Rufrzblfx01uz5W8i7l1rjUMva7QS5a
	 HjcCdHee2Q01ATlKG75YzVTSlL11jFidPeaERnjD40qviMhmeJgkoJVIj1UnUi5Vd6
	 m2w4GtLNDklB4BhHCTlLivvyaXSuU6VUSdpHzKojZjNR6IGm5wfdBsxXzsecm3wYVS
	 Ixv+F3QGNCfnw==
Message-ID: <014a49f07aee0fda5b03706f2fbd9de7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710162526.2341399-3-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-3-jbrunet@baylibre.com>
Subject: Re: [PATCH 2/8] reset: amlogic: add driver parameters
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 10 Jul 2024 15:34:45 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-07-10 09:25:11)
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 8f3d6e9df235..59126c9f194a 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -18,7 +18,9 @@
> =20
>  struct meson_reset_param {
>         int reg_count;
> +       int reset_offset;

Make this unsigned?

>         int level_offset;

Probably this one too, but not in this patch.

> +       bool level_low_reset;
>  };
> =20
>  struct meson_reset {

