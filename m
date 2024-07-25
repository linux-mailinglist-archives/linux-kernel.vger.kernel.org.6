Return-Path: <linux-kernel+bounces-261884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464893BD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C2F1C215C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B9172BA8;
	Thu, 25 Jul 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD8HBntN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657F172791
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893843; cv=none; b=o1dFmqFRVmquy4+vR37m7a0Yxnp/RYS1YzX3zojKiJ3hy96EN5nFdk2UjbHDr8a0AFMS//IXRISEJSpUpzBHEuPGzfNSqIy9erJB5bEf75AARIgPqGDoEtkkhEoH8FSkCd23a+AuvNCmEwuGZs/tg23JRQuY4aokML8EsWIT9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893843; c=relaxed/simple;
	bh=3AHuXOduCNHiVYwcs87eHPsuIAXODhLFLXa6d1iqs9M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dbOYiwePYNdhHUGci9QZEnl5yevnotq7MUlbaLsqbOeDA8jOCgucIf3hrPZz1lpElz9Z1jBtVOCiVFp8n/svSyp2T5Ofuw7D9E1+E5spAudWbAyB4T2+ze1TennS7YScZFp4Nz7xDln+iQzRz41hCSgQH4ic4rmxxJpvlcP/LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD8HBntN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE7C32786;
	Thu, 25 Jul 2024 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721893843;
	bh=3AHuXOduCNHiVYwcs87eHPsuIAXODhLFLXa6d1iqs9M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mD8HBntNl/x9wqfEhpqvpmnPC3U8r7rRRnmX8JK77/eIiTJAo3Kc/iJ/L5DfFZ7/a
	 GOf2NJKUKRJSEMMkbDbavxuVPZoyR87fuzAluHShT5jmFvaWnfNwPMhc2RyR0kIF0M
	 /d66Puri4UcznayccZLyyyIw6h3tb1wtu8cxipGcNwzh72dGu5kc/iPYKjctuE4vb2
	 deil01zw0l/DuiDViA+TFB+X7zH2/8nwjErKc4ahGMinbso1ZYQXyo/L/ns92xKFMf
	 tCX6AFeaQU6HfY9zv9F7+k5YmkDREYu8szKIm/XzoO5K7xBPjHwypYwT/xk/7glHsp
	 1bsho4UVL98fQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
References: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] mfd: mt6360: Simplify with cleanup.h
Message-Id: <172189384152.837660.3590109373140262352.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 08:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 07 Jul 2024 13:48:22 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
> 
> 

Applied, thanks!

[1/2] mfd: mt6360: Simplify with cleanup.h
      commit: 05dd1b4a8d71b5c422bff8bf6ad22baf5722c2a2
[2/2] mfd: syscon: Simplify with cleanup.h
      commit: c80c7dfec9d8514f1fcc34402124026e59d2e2cb

--
Lee Jones [李琼斯]


