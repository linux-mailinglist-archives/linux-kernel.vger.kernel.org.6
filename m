Return-Path: <linux-kernel+bounces-357984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A180B9978C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6255A2851F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B581E1330;
	Wed,  9 Oct 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK28biQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85B155316;
	Wed,  9 Oct 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514737; cv=none; b=KCU5aeMrj6cdo4iI8pwd0ugFi1Yp/9OT53UhkwW37SrMkZmQ2kKVzeqh5+0wczdcGxWWxz15rgTyhN4D0o2+Qhm9VfOocWnU/gWz9uBjQxAKhA4fDS9h7qW0FlhT3ssP3O3PougbPGMrVL5lkzHV74Qn0aM8DT/UT55O4JSRExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514737; c=relaxed/simple;
	bh=SnQ1TywTJdfiF9q3SWAVcOKq00ppyhQzP1+meZIxSns=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=K2lr5uhgQjMSeEbrFjYOssu9oYZ7reLYdXi/WdyKe0DN2t7C8JTWmkQDIrsMtozdiFc8YV7zzVPPFdK9FcrYAanmUONs5EZ3ootXszUefLjacbKqRxmQ+0gry7dvileLwTta1r1KvLN+dpnvWC+OqBb+RTGSLhoRc7Ebll6wLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK28biQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64742C4CEC3;
	Wed,  9 Oct 2024 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514736;
	bh=SnQ1TywTJdfiF9q3SWAVcOKq00ppyhQzP1+meZIxSns=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aK28biQjaP6bjx/B8Atm1VT/A82PqyXoZ3g7jhRZFMu3HMPuADGGTIJr6CWQ3P/6Z
	 UUWZq4uWl85+ObwDDWHgNfKHs/8gE1tY4srXaezJDL5Ujwpzyz0oUHPNLCwqlFNadC
	 ELb2C5VHm8ryyqVBJd+N+TawSWYu+cu/eJtBo3eMCe6Cwe9rRTbhdh/banEldPxpDs
	 rhEqMsL7gv6kMdYWYRkd4JcwAmOKOtjXb6EsWYEPYdX8TkpXWx3+fTG8mEyG9cyuXE
	 aKrhj8Pds6ZSFXVrO/xWjJymNX/bMAcFEOsSuQlyEm9dLY9WYc4lyEcpnXk5vwg9Q+
	 GUgTyym4beFkQ==
Message-ID: <92d5e28d2e7013ff393ed5d0ce1538fd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain>
References: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain>
Subject: Re: drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses() error: uninitialized symbol 'ret'.
From: Stephen Boyd <sboyd@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev
Date: Wed, 09 Oct 2024 15:58:54 -0700
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dan Carpenter (2024-09-18 03:29:07)
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   adfc3ded5c33d67e822525f95404ef0becb099b8
> commit: 9799873717398e8fa1727482e578b9d777da645e spmi: pmic-arb: Add mult=
i bus support
> config: mips-randconfig-r072-20240916 (https://download.01.org/0day-ci/ar=
chive/20240916/202409162313.TnpH4qKB-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 14.1.0
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202409162313.TnpH4qKB-lkp@intel.com/
>=20
> smatch warnings:
> drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses() error: u=
ninitialized symbol 'ret'.
>=20
> vim +/ret +1782 drivers/spmi/spmi-pmic-arb.c
>=20
> 9799873717398e8 Abel Vesa 2024-05-07  1762  static int spmi_pmic_arb_regi=
ster_buses(struct spmi_pmic_arb *pmic_arb,
> 9799873717398e8 Abel Vesa 2024-05-07  1763                               =
       struct platform_device *pdev)
> 9799873717398e8 Abel Vesa 2024-05-07  1764  {
> 9799873717398e8 Abel Vesa 2024-05-07  1765      struct device *dev =3D &p=
dev->dev;
> 9799873717398e8 Abel Vesa 2024-05-07  1766      struct device_node *node =
=3D dev->of_node;
> 9799873717398e8 Abel Vesa 2024-05-07  1767      struct device_node *child;
> 9799873717398e8 Abel Vesa 2024-05-07  1768      int ret;
> 9799873717398e8 Abel Vesa 2024-05-07  1769 =20
> 9799873717398e8 Abel Vesa 2024-05-07  1770      /* legacy mode doesn't pr=
ovide child node for the bus */
> 9799873717398e8 Abel Vesa 2024-05-07  1771      if (of_device_is_compatib=
le(node, "qcom,spmi-pmic-arb"))
> 9799873717398e8 Abel Vesa 2024-05-07  1772              return spmi_pmic_=
arb_bus_init(pdev, node, pmic_arb);
> 9799873717398e8 Abel Vesa 2024-05-07  1773 =20
> 9799873717398e8 Abel Vesa 2024-05-07  1774      for_each_available_child_=
of_node(node, child) {
> 9799873717398e8 Abel Vesa 2024-05-07  1775              if (of_node_name_=
eq(child, "spmi")) {
> 9799873717398e8 Abel Vesa 2024-05-07  1776                      ret =3D s=
pmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> 9799873717398e8 Abel Vesa 2024-05-07  1777                      if (ret)
> 9799873717398e8 Abel Vesa 2024-05-07  1778                              r=
eturn ret;
> 9799873717398e8 Abel Vesa 2024-05-07  1779              }
> 9799873717398e8 Abel Vesa 2024-05-07  1780      }
> 9799873717398e8 Abel Vesa 2024-05-07  1781 =20
> 9799873717398e8 Abel Vesa 2024-05-07 @1782      return ret;
>=20
> Is it possible to not have an spmi node?

I'm amendable to a 'return 0' here.

