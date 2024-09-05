Return-Path: <linux-kernel+bounces-317842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250796E463
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6155D289C97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11B1A4E96;
	Thu,  5 Sep 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9RKF+O3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18E3D6D;
	Thu,  5 Sep 2024 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569312; cv=none; b=dW+LUhNRS3HqKA+GucmCz9U7p8ZEnUGwSwVvCwqIlZLEyGrDuOsUqH+HpI4OqdRFXzMtlOHUWXh5rwnsnjb+2dpWCAmb5l/n1NqAOt3u+UiZ4leY1HQ2dAxWkRIiPprqt1f48PIOE4M3jaH8+IZUE40j3KzR4yJ+024IWFFhPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569312; c=relaxed/simple;
	bh=n8gdh251GMi/HobApqpudwIKyUEsKeukPfUihdydaUQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PoRjcv5p1PGJkrpTaFctW88brQfcTrbBoubrA/FS9VujdPUav5muUzs89YnKdqSwM1bc1+vu4aFZn9Xq/BGtYfnk8VYPExB550Afg+ZXkt+WveTwdIqbDPjuNr03h9ceU/KtnNCv5vJ93egffjs7JjkBFsTEmNN4yMa6MvAVtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9RKF+O3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8F7C4CEC3;
	Thu,  5 Sep 2024 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725569312;
	bh=n8gdh251GMi/HobApqpudwIKyUEsKeukPfUihdydaUQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=M9RKF+O3xRGjLbyvuNCjv0pN/C8IhbDHckUmI1JSLFcChEm5NIqZyf0pulb/9AlJb
	 zN/kXob64zgAWqPpaKo2MA4BfX5nIxj+dxV5AeubsJ9UkPOlF9lCReqyRu5HPNI3Jc
	 Z9s7JlHJtigB/ftiBHrTI31hMhSHwZYbkn0nIMQsFYn4aJKR+Ger50k2oWsnoQJlNf
	 az/2L9hoAfEay5rRslZSYK25vf2ZxOEKCKzpBUf596stJZ97mrzyfcd0g8KHsxfTVL
	 LJVOmpnFLEoowSXEtzsvmjpzlTSGqKncdNPs7jCkTq0Pq3Wn5gt6ismKZq23LYFaHg
	 M53w755XlaFvQ==
Message-ID: <6b92cf539fe4414967a98fefcd5a965a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240904-devm_clk_hw_register_fixed_rate_parent_data-v1-1-7f14d6b456e5@maquefel.me>
References: <20240904-devm_clk_hw_register_fixed_rate_parent_data-v1-1-7f14d6b456e5@maquefel.me>
Subject: Re: [PATCH] clk: fixed-rate: add devm_clk_hw_register_fixed_rate_parent_data()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, nikita.shubin@maquefel.me
Date: Thu, 05 Sep 2024 13:48:30 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-09-04 04:41:07)
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add devm_clk_hw_register_fixed_rate_parent_data(), devres-managed helper
> to register fixed-rate clock with parent_data.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Applied to clk-next

