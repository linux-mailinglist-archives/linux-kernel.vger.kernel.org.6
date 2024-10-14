Return-Path: <linux-kernel+bounces-363726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375499C619
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFA1F22CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65F15884A;
	Mon, 14 Oct 2024 09:42:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BB156F39
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898937; cv=none; b=oAvPjiZN+2+OrW2JJ38nA/xnefL+ImPi8jsFZuzji/s/QV4dVk2ExlBPs90JEifHutMWhxoQd8+eAI9oNd8wNaoqt4n46iwA+DhwAFnj8Lz2ZF7gmbM+OuDHnXvtfdrm5rgHIIzGIIwK/hI3nOwlQkxS/5YAwLFW8hL7F2Rpv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898937; c=relaxed/simple;
	bh=qJcliQeqBzue97fNDY1nWNca3J5whJG7qSMM/6IwCW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsTCCozDr388RlFsQgyclW5QWXFQdFKbRFKmVOv1dJyp9VvIm85e0GrraZCgGJbIMzEfqxmQc85c/DdEVIQhP2cUPYT43vhjWeC4vScj7Js0EvW2jv8Z1lvzpv3fNSW9V80ONT3chEZjYdDfJYCI+sw4YVrC6P+Gu9E4jyey82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9521424;
	Mon, 14 Oct 2024 02:42:44 -0700 (PDT)
Received: from [10.57.78.229] (unknown [10.57.78.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26CE73F71E;
	Mon, 14 Oct 2024 02:42:13 -0700 (PDT)
Message-ID: <9e81d3b6-3567-48f0-994e-9cd60fd71955@arm.com>
Date: Mon, 14 Oct 2024 10:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Add support for Cortex-M85 processor
To: Jisheng Zhang <jszhang@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241013132435.2825-1-jszhang@kernel.org>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20241013132435.2825-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/24 14:24, Jisheng Zhang wrote:
> Add processor info object for ARM Cortex-M85 CPU which inherits the
> setup procedure, the processor and cache operation function from
> Cortex-M7 processor info object.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

