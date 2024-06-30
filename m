Return-Path: <linux-kernel+bounces-235251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848591D24B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA99F281DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA076153BE2;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AD1527A7;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760177; cv=none; b=kAoI++O4MnT1qSd3IfZSDbZwhC+eU7Jw4wBoLbB/ySsnJEEoFR5DwyOYZ6o4AiwtpuX7E2AVjOj3dBSpKpiaVPOBTYsWohddEOif05CNX9v1rjZb363gxr/hURNm7UReY9Tv/w+BL142WsxIvKBE8ASsSEAwF3SZnF4ZOlGn3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760177; c=relaxed/simple;
	bh=N1bZStuBZrr92pOiamm4mgNLr0wuwdAQEW4xoSlpV3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pw8tlWUW8JyGHxKRwRWwycdn/3fmIHBeptJvu2ar9oQ0gT34YTp4ZhNHpvExQlc0jz0w6Nq9hlz78Ouv32ZzrnHKCYg0JkOrtUDDtqViyo83woPVErhML4oOgURvJK94q781herYt2Ui4zJ4MzHYEGvONhUg/H8+S8bYEA82GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD9C4AF0C;
	Sun, 30 Jun 2024 15:09:36 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 9CF305FE30;
	Sun, 30 Jun 2024 23:09:34 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240622150731.1105901-1-wens@kernel.org>
References: <20240622150731.1105901-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 0/3] riscv: allwinner: ClockworkPi and DevTerm
 devicetrees
Message-Id: <171976017463.1183261.6835267708934642327.b4-ty@csie.org>
Date: Sun, 30 Jun 2024 23:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 22 Jun 2024 23:07:28 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> Here are a couple patches that were originally sent by Samuel, but later
> dropped due to the system LDO regulator bindings not getting merged. The
> regulator bindings were recently resent and landed [1], so now is the time
> to get the rest of the stragglers in.
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[2/3] riscv: dts: allwinner: d1s-t113: Add system LDOs
      https://git.kernel.org/sunxi/linux/c/8f2cf4442b49
[3/3] riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
      https://git.kernel.org/sunxi/linux/c/0ce1d34678e5

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


