Return-Path: <linux-kernel+bounces-518266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE828A38C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D237A1F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D5237194;
	Mon, 17 Feb 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9eV/lZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09643158545;
	Mon, 17 Feb 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821398; cv=none; b=pyQR4Yv1OAIxT7btn2Xz8w+zHugerWdmYmBrqYO+1pvZXsf29RN1luFZ8ABijFqt8NzIGYeaVrZMnP6vWuljT2JeEn2BwDCIJhLtjaEhHEVSRL6T5ydI65/Dm4VzmXRuyckNRPpM0Rb/KQHIz3pEEgRV8ExgzsvqzWd2hREatCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821398; c=relaxed/simple;
	bh=ThLrCm+7YW6B/mbul4nWe78MpCxp1xpJcUfQPIV2LMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eB9LJO4pn6FLZxZp+V4gg9Yv2auLYu4sCxK+QR2VeQePrBLueDABseEDQoRP/aFLlmGvD8FFdjG28tSnkBcgevY/Fo3sXnwpJ6AQde7JFeXsY+rLO9lJggWJ3K9chSAe4KyewD8MY/FCmRHspqQT0C4a5UBAtNz/i5FNSqlW6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9eV/lZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED419C4CED1;
	Mon, 17 Feb 2025 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821395;
	bh=ThLrCm+7YW6B/mbul4nWe78MpCxp1xpJcUfQPIV2LMo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=g9eV/lZLkGejx9mnawdrWgjQVSyjZWDC+l0vQCubvW6ddQea3qSuewgFwGdiToy12
	 NuWfCtcPmnI3gV97fq62t4qa5mSTMnqbwCZX/9C9kge82ut3R7IoZ/nw+NE9aTdGgr
	 iaPhbuX/nHxVx0k3vkY+h1+c2Pj0IHoeAXQbeVeeayAQ5+M3/M4+RXTppGEhArUuP/
	 NblLK9kCwthMb2MSJUJLYK7ZSLkVDCHUsIvUDynHS5qLTmgpa08yX/KUk5BgMuvUbO
	 0WBi4SMNKvCrlOQSGgGsAeONrpGgaeph4E1m8ReFHmD12gnXs7uSunzHve3rpiIMD1
	 EjdNL0SqZQO2A==
Message-ID: <0897d31e-c0ec-4b89-a459-0c5fdd17bd55@kernel.org>
Date: Mon, 17 Feb 2025 13:43:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: socfpga: agilex5: add gpio led and memory
 node
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250217120124.3502476-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250217120124.3502476-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/25 06:01, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add GPIO led and memory node for Agilex5 devkit.

Looks like you added LED and memory nodes, and enabled the GPIO. Please 
word this commit log correctly..

THanks,

Dinh


