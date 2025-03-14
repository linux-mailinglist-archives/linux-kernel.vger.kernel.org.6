Return-Path: <linux-kernel+bounces-560577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAAAA606BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EDF460F07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72896EACE;
	Fri, 14 Mar 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC9Y0ae0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4003D530;
	Fri, 14 Mar 2025 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913687; cv=none; b=C3HJTgaspB7z9yN9FMipYRDRLP1zgHdfT5Yuo2VxTjBkc7Q76F8f54LzDWpx7Pg+haRomQZD3TkNGjDT40JArQllS2LaqxErelJ8Amdmz8uuVXl17Dy5hM4ysP8oBZ2vYkmDfP5N9Vk4SMoPiPj4hgLODyyhvipk0ioO2V2gYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913687; c=relaxed/simple;
	bh=KCYIbCrQZwsu+PQS1yLr2L5sQDC2z1fQCiKH9QPI7NM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=uQkgcrYswVcEuvTrmjCxMk/bhGe0a6Uk2G15e6GPF3erDogHGRRk9vQhCO1ATqStmgqR/0ZzGOZyohzA8QgFpukTsORMJrD6aun4udFSjr5l62EZwHNRvg+Xa1HHwHi1sBgCIP7ScWJmqY3yYOr7mW4ZONgBsQiAuBI2eNn7B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC9Y0ae0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E79C4CEDD;
	Fri, 14 Mar 2025 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741913687;
	bh=KCYIbCrQZwsu+PQS1yLr2L5sQDC2z1fQCiKH9QPI7NM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OC9Y0ae0Cm9jR/tBzJ0LsYm4QsrDgPchHMdCYc6mO9rTPaeTMwMmQ8RA9Ulkp9QXm
	 NNdRiuYmFtndrQ/QG6ntfLfctDLlhLFzNnDOkDXLsdeSqcsI6rRyAftdsLTeKuyjMD
	 lMHUKqY/pJxI1VvKg+48uWjZsVUx1TblZ9FvmaGw1ZfVP/BJFWI5pmeoghM8QLKLKw
	 5u9z6ZiNSV/5r8rEoMyd2MBk97ZARe1kRX/2VloV/bGaIn2kOUcu86ElI7pvpw0LD1
	 MA7MzgtxKhZow5SyK8PkxP8B6UPShhV8tf74CAVHawAvZKeKA6Y//3CtQqggaWsBe6
	 cew9Uuyz+VJVQ==
Message-ID: <843824c0ef2e4cfc5307931c9a8aba2f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250312215923.275625-1-heiko@sntech.de>
References: <20250312215923.275625-1-heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: reset: fix double id on rk3562-cru reset ids
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, p.zabel@pengutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org, kever.yang@rock-chips.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, kernel test robot <lkp@intel.com>
To: heiko@sntech.de, mturquette@baylibre.com
Date: Thu, 13 Mar 2025 17:54:45 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Heiko Stuebner (2025-03-12 14:59:23)
> Id 173 was accidentially used two times for SRST_P_DDR_HWLP and
> SRST_P_DDR_PHY. This makes both resets ambiguous and also causes build
> warnings like:
>=20
> drivers/clk/rockchip/rst-rk3562.c:21:57: error: initialized field overwri=
tten [-Werror=3Doverride-init]
>    21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x2000=
0*4 + reg * 16 + bit)
>       |                                                         ^
> drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3=
562_DDRCRU_RESET_OFFSET'
>   266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/rockchip/rst-rk3562.c:21:57: note: (near initialization for '=
rk3562_register_offset[173]')
>    21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x2000=
0*4 + reg * 16 + bit)
>       |                                                         ^
> drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3=
562_DDRCRU_RESET_OFFSET'
>   266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> To fix that issue give SRST_P_DDR_PHY a new and now unique id.
>=20
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503121743.0zcDf6nE-lkp@i=
ntel.com/
> Fixes: dd113c4fefc8 ("dt-bindings: clock: Add RK3562 cru")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next

