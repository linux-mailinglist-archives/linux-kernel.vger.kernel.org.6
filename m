Return-Path: <linux-kernel+bounces-533827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282CA45EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2F7AD254
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73982206B2;
	Wed, 26 Feb 2025 12:25:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F315C0;
	Wed, 26 Feb 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572724; cv=none; b=EvoQXZNdoJNdcFB3lJ/+zH+1uVpa8uhZpoFFA1SRDqq3yCdLEC5Q9/h6/r8jcgmPWIKTy8wxljE9C+MWeWE53lQY1jEIJ/haBqHH81YWroY/M94hxKUqZz8sQfz2NSF/5uQR5kUF3c+eMAoCSp9Z9B4LCD6IQoK+RfSXjsh/u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572724; c=relaxed/simple;
	bh=mpx3OIfBMVbXEbYqM4lIodKuC+dxywUF7P5xsFaOeA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOTXi3s+E0orU1DGhkt6gphNKvzQOiBfLjJ/l8gZgVjT5vFC9sPHe7QWRADrmejYzpwjeXdwvxqtKL3iOV0XA6BGWtINcYDYtXhv3uaTN1px1qTrI6GkKmqKUCdwCbnvQpxVKgoHDXMQ2Sq830ibTHDLqjWpi86haIKj3FiOJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D573497;
	Wed, 26 Feb 2025 04:25:38 -0800 (PST)
Received: from [10.57.78.198] (unknown [10.57.78.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51E4B3F5A1;
	Wed, 26 Feb 2025 04:25:21 -0800 (PST)
Message-ID: <01eec26d-9ddd-4ef4-b921-dd7ff4dd0e23@arm.com>
Date: Wed, 26 Feb 2025 12:25:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to
 json-schema
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org,
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225190746.541587-1-vincenzo.frascino@arm.com>
 <20250225190746.541587-4-vincenzo.frascino@arm.com>
 <20250225221945.GB3224894-robh@kernel.org>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250225221945.GB3224894-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rob

On 25/02/2025 22:19, Rob Herring wrote:
> This was in the example, but otherwise wasn't documented before. And the 
> Linux driver doesn't need it. So let's drop 'interrupt-names' because it 
> is pointless here. 'spdif' is redundant because this the the spdif 
> block. 'interrupt' is redundant because it's only interrupts in this 
> list.
> 
> Don't forget the example.
> 
> With that,
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thank you for your help!

-- 
Regards,
Vincenzo


