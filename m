Return-Path: <linux-kernel+bounces-235248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ED91D23E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DBB1F21476
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE51534E6;
	Sun, 30 Jun 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEV6mBHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A01135A65;
	Sun, 30 Jun 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759991; cv=none; b=pQu+c5E6OEghvWaPovxe+3Jlo3Dm+3spe0SzqS0O5vqDss2CDGM3ML1GQZtpSxcb2wJyslAASz8tUiQY9B1RX15qSIUllrxV/AX6t/eMgexiBTYINOBiJDLwas7kspt8P07XyFY3ijvCgSs41y6R4aKVrlTn9PL94ESm5x+1E9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759991; c=relaxed/simple;
	bh=c+JK2VSNQ31PnD2iQNuRuQbry+DoqeD124arYuJ+Juw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLAtXktxY/K/E5CjQHA64WZJ8dK35xxaTYpliK2FzXLHabX+eP49DOS+WJgGTR4r4qZOBI41ZxWPpDk7Xo8aZZXezoMLHYoXBOdiynNOrEWM9mpvfbecKnrYpV6CKu/64FEZTBWV6xASvytSI/cSsVc7Md2SZVXEFPVhquQEchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEV6mBHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A87C2BD10;
	Sun, 30 Jun 2024 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719759990;
	bh=c+JK2VSNQ31PnD2iQNuRuQbry+DoqeD124arYuJ+Juw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEV6mBHYlCdS2EsLB3+1Z+jegmRJYISn1E6aJWP8DJf7/ZDu7B9YbhsWuL4L04Tki
	 rDIus2kqQ9Vzk6hQASgX42OhzRpJIa/jkeF3GPzgwTVdVrWtFuMXKCCITnd89CetSz
	 bx8lLyu32y9LigNdM5B71TKlRPHfGEKpwJDDqIf5ofQ06fprpfoQUtdLnusKwOkLR4
	 T99F4w6aSaZl6oXo3CVPuMbmouJvyDoFpYZPRCE78XL/W4KcURso2ThVuP9TsupsV6
	 T0XhcUN6IC8azj9sFxEhrjg4H0FdeUrKDZySdOOeX3L708xEwYCARQpOVaPCKGALel
	 t7JWg5vj6ugXA==
Received: by wens.tw (Postfix, from userid 1000)
	id B90A05FD47; Sun, 30 Jun 2024 23:06:27 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] riscv: allwinner: ClockworkPi and DevTerm devicetrees
Date: Sun, 30 Jun 2024 23:06:15 +0800
Message-Id: <171975990845.1182816.12708794418763846620.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240622150731.1105901-1-wens@kernel.org>
References: <20240622150731.1105901-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

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

Applied to sunxi/drivers-for-6.11 in sunxi/linux.git, thanks!

[1/3] dt-bindings: sram: sunxi-sram: Add regulators child
      https://git.kernel.org/sunxi/linux/c/3a6fb9025cdf

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>

