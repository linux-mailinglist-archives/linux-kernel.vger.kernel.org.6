Return-Path: <linux-kernel+bounces-556704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA419A5CDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7421A188817E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72712638AC;
	Tue, 11 Mar 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXr6HCno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F82620C3;
	Tue, 11 Mar 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717109; cv=none; b=I4BLcDlRgPcKoLfLAMbNEHOxFVv2bAZ5Lmcfnbz7Nb29Np+QG9afpY3Tuv7lJrP0DwMuYlgDNbCJZijhbvnVtHd6a598JaQlWmHV0eSkC32hGi7qzx14AG3XtxLfEUBj4CVzwqh0LDaKFdvHMni7hnp17UeyBV/MfHPpimrvhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717109; c=relaxed/simple;
	bh=022RnomY3mAc+2RTtmJ6xcrKdVXRF9n9VsGw1okq6uQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=jQ/Nx75mKI9TnvklFkxb9FNAYIfYwBIiqFTklDHYRKMmBJAtNfzhRZPK6+bsHnDoEJoULw1GXRlZ3fpAyCnmBYP1NZOgNX4QBff2XAR/h/ddxXmy+940k4AOMsPtuTPVYTypIHZWWMyD+Cy+qpZKmsCvQVnuCC7VgIHmrEl5EFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXr6HCno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856BC4CEE9;
	Tue, 11 Mar 2025 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741717108;
	bh=022RnomY3mAc+2RTtmJ6xcrKdVXRF9n9VsGw1okq6uQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GXr6HCnovY5hjygoUZFISGN9FPq7MIzpO0SpbkZlWMT1RjfM+I+lHuMD0RFyhBRc8
	 UsgK7jOw4MHDpTakAz9Xb8s9WQE0CWPa9vIkl8dPIfkNSnVxeZc7rcxsVcqwxT2Y2t
	 +NT3kLYPZci1iyF9sYSsjNjGru5h/XmS+zOV1Hc8UaKep/DAWoV7x+EdN7T8W4KioB
	 FLyYC1kR4HSnseTeGG8aJvKDxAH40OafZ1pKVTsZxD+HwVhJj3MgXa6hG66u/O/rrW
	 r2x9kzs1Oh/dHdnSi8fizruSwEukkdfSBPtWxYfQB9+h+61u4CUS+qfcnoGsW5cQmZ
	 gKF2jlWmHkmpA==
Message-ID: <c6cb66744fc8986bc997d9e9e03de12f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250311094140.722154-1-abel.vesa@linaro.org>
References: <20250311094140.722154-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.15
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Tue, 11 Mar 2025 11:18:26 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Abel Vesa (2025-03-11 02:41:40)
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f0=
5b:
>=20
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.15
>=20
> for you to fetch changes up to 06a61b5cb6a8638fa8823cd09b17233b29696fa2:
>=20
>   clk: imx8mp: inform CCF of maximum frequency of clocks (2025-03-03 19:0=
2:15 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

