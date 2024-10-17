Return-Path: <linux-kernel+bounces-370511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224E69A2DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C657228494D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09602201270;
	Thu, 17 Oct 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfJ4KjPz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D7193409;
	Thu, 17 Oct 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193412; cv=none; b=aq2bNEfL76kPR8po2uiojJAH27ce3Khp1t1UwbDt3gPDBbStLxs0uuLdkXOwsZql4zego2fODUh4T3HVZLQgKj/4lBWX+ulKToSyM+v7Wju7/1QguapFNTfofAP5Xy0gp9I1tqeqDMzIY6oDcVrRaozTTyhW00rVL/pWfx5x7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193412; c=relaxed/simple;
	bh=FgGw+348hq+8XaJjRr2RQ3h8zLKyBzjTagmsfJeeBVQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZHVyoRFp8i/jxGpR2DoFGhD9CcdKxVzBLRCsZshsWYnRAAjoyDufVEMs+j1b1gX0SgEWKYc6sNQhxUz4fXEzc/05goeCMQ/fO2yM0KxbAIW0PNJhmN6c3vRZ5VZzOrAdXN6swNcQtvNGGJ9vixxyI00SB+OXqs6K4LNrcGhiXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfJ4KjPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEBC4CEC3;
	Thu, 17 Oct 2024 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729193412;
	bh=FgGw+348hq+8XaJjRr2RQ3h8zLKyBzjTagmsfJeeBVQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DfJ4KjPzP5fLnkvbrv1jOSYYFT/OAzw2b/vS+1ZwAyVybbvP1cg5fRueMCn50bs9u
	 Vrdyaph9ggPybHJPCg7+EqeWM4ptUnLApy8O/HObuu92Qdslz16dfgcUaThYNqQ0r3
	 q+EAFpsD7A2RILPucjP0D7EYnd/TH6fTpqAuxQs3Z5BTXO5xbe/SiGdSKnrTBwMJB5
	 UzUUnCOzNudLScpRvofZmg4pr+/64pynMpogFOUlj+XgUiL7oQvuevXYmJeRcET/tv
	 1fDcoMqwhjCQVY2duwyAl7QKk66QgUMq/AFyKi25fRVVwy3VMv4lpCzDF4LZoXuOED
	 sOCvRn5ZZD63Q==
Message-ID: <18b311f580dfd0640db076d066ba5286.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241017071708.38663-3-y.oudjana@protonmail.com>
References: <20241017071708.38663-1-y.oudjana@protonmail.com> <20241017071708.38663-3-y.oudjana@protonmail.com>
Subject: Re: [PATCH v7 2/2] clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers
From: Stephen Boyd <sboyd@kernel.org>
Cc: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Yassine Oudjana <yassine.oudjana@gmail.com>
Date: Thu, 17 Oct 2024 12:30:09 -0700
User-Agent: alot/0.10

Quoting Yassine Oudjana (2024-10-17 00:17:06)
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks and resets
> on the platform, enough to bring up all essential blocks including
> PWRAP, MSDC and peripherals (UART, I2C, SPI).
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

