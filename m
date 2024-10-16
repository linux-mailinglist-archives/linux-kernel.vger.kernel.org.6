Return-Path: <linux-kernel+bounces-368570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B39A117A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4161C20A32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B9212F1E;
	Wed, 16 Oct 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4UBKIap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DF212630;
	Wed, 16 Oct 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103178; cv=none; b=D6yVm/UXDATA0p4HeUtwC6ysWQd1iu+gquFjCiJLRPg9VjZ5M0awstawMgeWITbSe+IF99vr/+CcdI1+swUIGAWe7fCU5MmGo2Gawp3bETX6FBDFIig1v1LzSgaJKtWtE7Ub9f76B1R2Ut7wkkjp95czFDIGZVLDrpkCaKqcyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103178; c=relaxed/simple;
	bh=0oOymLDvhYXs67gpgWJ7cSTf1poXhsQHPnLDygcjXWE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JBkV+F63iOj8cvHvBochSbPSoqqAQqvk4VyZV64E+T7xPCpmCr/7iVbQvCO5fw8D0h8yO2I1A6PUO/bPuImHcqGwtQKXoKA0Nv/fIb+aNeMFffrnXiBUkBRrNKHWnN+JZ9/sxLtR1G0N4JyyAZrd32ryMAlI6swZs4Km7PYRjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4UBKIap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39DC4CEC5;
	Wed, 16 Oct 2024 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729103176;
	bh=0oOymLDvhYXs67gpgWJ7cSTf1poXhsQHPnLDygcjXWE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j4UBKIapkJ18PQGiD2O4MFifu/7QTmBxotnxoTem5aP0htkDpXaO1bNX2GQEjCGHF
	 ymzVYc/CP1tSr+zhecym373anXwrXJ9S8xR1wHovo6McbxsoMPF57Tj0oL4Q1jjm28
	 5M8yYVutya9PrdEgAl+lzaiVR5/pkRaNnAYLCaNVZd90c6Eu4z10rchUFo7VH9iWoG
	 CZntDe1SDYbDdPZwM6zHQsGh3wUuGNLaXApfvtSOiKvNDxBmS31jKD3AuWlh25vXFG
	 kDINH+/4eRMhEkUsOlr1NDVeNaWMvZpm24nrKx/aivAoC6aIoyWHr3A5CLoU3Iowxg
	 IJw5bBmeqJi4A==
Message-ID: <b586b57f597897cecde26054db4d5fa1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240906082511.2963890-3-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de> <20240906082511.2963890-3-heiko@sntech.de>
Subject: Re: [PATCH v4 2/5] clk: clk-gpio: update documentation for gpio-gate clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 16 Oct 2024 11:26:14 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-09-06 01:25:08)
> The main documentation block seems to be from a time before the driver
> handled sleeping and non-sleeping gpios and with that change it seems
> updating the doc was overlooked. So do that now.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next

