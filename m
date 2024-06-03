Return-Path: <linux-kernel+bounces-199784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08648FA5EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333FE1C2186A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E513CF96;
	Mon,  3 Jun 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/W6rpvX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8B13CA99;
	Mon,  3 Jun 2024 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454586; cv=none; b=iYdgJ09y8KCaNC5bkL4xiq7bJpUoaOrjYTaghcwTNi9ZN+RsVlzJKET1nhvoU1Tu+dYGkRENPbzU/Ibosmy5Ghic2DYAf5hYTCdmp21NiPvjlRoXitWAj+bjj3osQioaa/TA0BnvEWWfxahQkU8J/u7kGthg+abl1kC6mkC0mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454586; c=relaxed/simple;
	bh=X89c/4kJoOnE6xEof+UdYth/gz92oKd6pJiDL25w6Oo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ls9wsSVzWpLZMmIIPkB8DN3dku3FmJaYysAXOm6WkpvfWK0N68DUqfYNNbSzFsECT+3yxLQ0R88+N/ycD2dV3XvMxcNCk9YIHKMXHjTnkz27WCWhNCQDQa6i7T38KVoXOsy3LUA+rJR/qTfu4U0vqrp7N9d8Sd4CNIpZYzlzvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/W6rpvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F02C2BD10;
	Mon,  3 Jun 2024 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454586;
	bh=X89c/4kJoOnE6xEof+UdYth/gz92oKd6pJiDL25w6Oo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=f/W6rpvXdxKThNc9fRDatE1Qr7floTRstYgbBL+joVeYW0kOqO4OKZdid0ohZAkyS
	 wZATMs5Af51JAduqyUgAy3j0fVvI8+60nKvHuioRAf6SbslCAG4JxtLf98mdyPF0km
	 8fFARhtZDgA1F/QkM3OFokZ8CofAyIBa/O7DDveks9sfcdbTbCe0npkjyah3TCj8WM
	 /1MKZh23xOLXSTBk3hG+uEf9B7gey2MEe74/A8kfkwG5HtalHPFh8IrSmvCazG8TBz
	 cGri22ghLlWWZpmhA1/sXtNO9CUAN0DBaMwa6euaGZePx0rVUWc4fmu0HHFMBIkRKr
	 dAwO8UCQz42TA==
Message-ID: <37dd5b528f21d3b32de2c97cc4c0837a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240601-md-drivers-clk-sophgo-clk-sophgo-cv1800-v1-1-8e00d8c3a87b@quicinc.com>
References: <20240601-md-drivers-clk-sophgo-clk-sophgo-cv1800-v1-1-8e00d8c3a87b@quicinc.com>
Subject: Re: [PATCH] clk: sophgo: add missing MODULE_DESCRIPTION() macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
To: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 03 Jun 2024 15:43:03 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-06-01 21:44:22)
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sophgo/clk-=
sophgo-cv1800.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---

Applied to clk-next

