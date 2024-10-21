Return-Path: <linux-kernel+bounces-373837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED29A5D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B805C1C20431
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9B1E0E03;
	Mon, 21 Oct 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqrqiA/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36F1E0B67;
	Mon, 21 Oct 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496921; cv=none; b=dcwaOMJS70hLZ5niIkkEeJ0EJwOdWLOwaqmsxpsmRTQT6tBeHXCse+iZ8x336Q5noOY+QflBrwO9U3kZ76W1eyt3q3/uMDfLsfGPYm2S5Sna2RKH9O4KipvCH0RgprJ2hB4Xfxi49kh8f2eaasfpoJbZW2KTl+hpVI5WfMcwhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496921; c=relaxed/simple;
	bh=qSpv3tBvMMGIwq7aMGW3Ea661hMS8kpa2sDYpiU/D/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF6xwHijVa6/KC0gAmHs6U3Bv3Ovzjwu0GRMydKSqpXim7oqFOmkVcvyF5TSNqiO/1bXY/rrFLRsOihpntqLgvS8QLgeYkTZHHHC4TZqdrkROKFWEA4J5QG1Q0do+pobaQshkwfl2zRqcOh5rCvhuzag3e2EczSxA7bDiIxKops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqrqiA/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47109C4CEC3;
	Mon, 21 Oct 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496920;
	bh=qSpv3tBvMMGIwq7aMGW3Ea661hMS8kpa2sDYpiU/D/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqrqiA/rX8wprOkxdM1qti2Oo/OgGh6Hvv7VanVnnlyf/IlucFk4usD4sBx6rGu66
	 WaUMQV5O9ID/9vScJyZquzqYtRMv0c9LFRtAXbP6TUS5Je0i11l4ZYeOHlYeiYP2Z+
	 g7OHapd0BogtfrAibHYr0y8TJuM0LEcUm47+ql52S2IOcQ2skVOCZBROuglkSaqJOb
	 /1bw1wAGxhImFNkaQOti1ikMsWGH9iMksMm1uJ/h4nMSfbFd9eju/kvhJKDuC15aDx
	 NAmDsFesB6gYWu8jFK2Qvt3BfDhiChey/aM5A5TxuczUG9D6+nsBG9TBgW6qLUJBqJ
	 iEZFwDxxAFKwQ==
Date: Mon, 21 Oct 2024 09:48:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/23] dt-bindings: altera: removal of generic PE1 dts
Message-ID: <evkk3wwfxrx4feyl6fedg5mmxdtkdueak7vse3hy3vgqxkc3iy@lzggix6oxnfe>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-23-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-23-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:27PM +0000, Lothar Rubusch wrote:
> Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

This we see from the diff. It's obvious. We do not see "why?".

Best regards,
Krzysztof


