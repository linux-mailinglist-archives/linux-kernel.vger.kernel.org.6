Return-Path: <linux-kernel+bounces-290392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C49955344
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EE81F222CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4F145A14;
	Fri, 16 Aug 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy3hphux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D61448E0;
	Fri, 16 Aug 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846907; cv=none; b=Swj8s8+9ljmBlH761DeANM1yaWoMaVntLd67vr78F+9cLre1wXefU3rzwv28j34jQyvAGFMqkXKuvooXk+1KyMwhQkZPEGHmZVhibrIh8jXRkYKjuMnfZC/hf2KsMWXLvzXRc3okr7v30rfIsKJslQcMbygtYW9E/2QmVKhsVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846907; c=relaxed/simple;
	bh=WgvoYVzCifcvYTm7L2k4XdMOnnqYb0WGXGPEg/mZ/v8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=cC0IBxhXK0FLWavwArPRLrQFQfZruMFWYN4dkOxVpyxv6EdTY3OPQDTnKZFjKBJ3T4ZNYVK9BN7PZ6JJtkbO9J08blRc8uIYGClixVnQQozsTJw+BIxnwNmeNgmDejFxxGN3x6PyxM58soFX3I2p0HEgSlsgj4WlP/6pbUngeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy3hphux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B384C32782;
	Fri, 16 Aug 2024 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723846906;
	bh=WgvoYVzCifcvYTm7L2k4XdMOnnqYb0WGXGPEg/mZ/v8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hy3hphuxMb54saXn66CHIaJezinIkNWYULZBqley/oeS/hSXmKxatpOAIJkK2LNXH
	 A/9/u1X6VWBo5yq/1iV4YXOSrg0L6VNxojGRp7w4QUodFIuRXI/iUGwSauJto3gO6I
	 1jG752fFt9Gm5nzPRBykDKLol1t2yEGlME0Y8AgHVQ77JKIQdHwdyqjW5tM3ginEQX
	 iNTDEKTwhOuO/NDI89q5az6W8osZTttHhoxjedVtqIaEo50cMpj0wo6wUgpTYrsEPF
	 vj0mG1oKq3b7a6YWc/nI7CpMbW/nvMPH3EQXaJW4yi8sf09SG0qWYw8UJoLnu77Zyl
	 hDOZ/nEhHy7Aw==
Message-ID: <679c72b4ee50f66054a90aebe391b4c9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com> <20240804-clk-u64-v4-2-8e55569f39a4@nxp.com>
Subject: Re: [PATCH v4 2/2] clk: clk-conf: support assigned-clock-rates-u64
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Date: Fri, 16 Aug 2024 15:21:44 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-08-04 05:32:56)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 System Management Control Firmware(SCMI) manages the clock
> function, it exposes PLL VCO which could support up to 5GHz rate that
> exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
> to set rate that exceeds UINT32_MAX.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

The patch doesn't compile because of missing slab.h include. I added it
and applied to clk-next.

