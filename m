Return-Path: <linux-kernel+bounces-252475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE23993138D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE721284143
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6718A93E;
	Mon, 15 Jul 2024 12:02:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065DE446DB;
	Mon, 15 Jul 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044976; cv=none; b=cpEAqpcTIza89CukLTVnUdVE80+tRxLrJXxIdJLAXgCoPTIHIO754m+DRAb/ONZ9XskpDDq2ia7glWKw8ws4RGpBgDS2ylUHDpzCYJlYZVdNM4VJHf1lrqjiAbcRF6IYZ7Df022dbP8p3UXFWfD0NAXcihKPJoLsA7OArvfc+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044976; c=relaxed/simple;
	bh=hQ4tXwoe7PZNQk873EVMFSH0aat0uH01m7R15qpqRe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIwu4QgQ/gzYP1lM/kiRBbZQk4qbJcRJOpypwHcjNgISLBYDVv6Mn2Ahd6jef8kAnSEb3byQDbSPFPg2NCdlBDaB1QJYfZw8j6z2iSip1jz7AvgaEdumCTgdCLBPdldDZk9kcI2iixmCFJv2/HZBhe0966Br4a6sZapJ/sDkBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2143FEC;
	Mon, 15 Jul 2024 05:03:18 -0700 (PDT)
Received: from [10.162.42.47] (e116581.arm.com [10.162.42.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C893F73F;
	Mon, 15 Jul 2024 05:02:50 -0700 (PDT)
Message-ID: <cde5f188-9b7d-4a7e-9d13-d431b54ed7a4@arm.com>
Date: Mon, 15 Jul 2024 17:32:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: missing arg in ptrace.c
To: Remington Brasga <rbrasga@uci.edu>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/24 04:47, Remington Brasga wrote:
> The string passed to ksft_test_result_skip is missing the `type_name`
>
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>

Reviewed-by: Dev Jain <dev.jain@arm.com>


