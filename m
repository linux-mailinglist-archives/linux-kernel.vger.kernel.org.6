Return-Path: <linux-kernel+bounces-328808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A8978926
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDCA1C2289F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A8148317;
	Fri, 13 Sep 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3GKdy7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73712EBE7;
	Fri, 13 Sep 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257161; cv=none; b=VJI+z3Ok8IAOqk9pAVj2QEdpdZmQi4HS90aXT78K/e5U3LAeyHfRak7KKtvN2D1gARIgnpJb1kOULDNnu+FxfmIMlGd0oy3/oI1pNgYcY2Gs2WazYK3AxQNV59JDXbak3B3CEw70IAPZUTHDH0GP3DCsgIxJX9oiO9NLDdiPjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257161; c=relaxed/simple;
	bh=7tBo3ZjTMI3VxiD8zdMj6JOB555N6CuBG+AekURdLdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gReKn6TzfGonHxgLvbRAUp23uVAmkaHfCsM5zzF6QdAH0bI9M7k0Ha2KtXnqvyjOfab2uxG3AgcHQzCjVbkyYLsZ16Ow1xJn2A309SQPGr6stqR78v2QnWfmRw2mrDz/d5MQWV2pyZw2Zj5OKVkFRIKxuV14pIkk3QkJfex2e2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3GKdy7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D172C4CEC0;
	Fri, 13 Sep 2024 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257161;
	bh=7tBo3ZjTMI3VxiD8zdMj6JOB555N6CuBG+AekURdLdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3GKdy7pXHnYrF46qwvrltwrqDDa47TEVtXiQRnqIxxznRN7cr7Dn7TuFlGYTbIM9
	 myFsGG1Rjt/v/0cwkJQ/PCUkHAVuDaIis4u+d5UXzII+/owDAaB49S553EceSzZxRy
	 HKEAQT0XJAqf3NobphQ3TO6sZzY7E5XjlKq1fe4jQ4G5eHknCAtFoRQ8iv2i31AaGa
	 jKoTs9xYCsCYlorS7rpe/s3yqyBkHqH7OOxqKU7jzdaxguN5n1/7GncauX5qwF1uIP
	 Vhz990YVmBKSo0l+eSvKrFVG4MVAlP6r5pRNy7gRcsY3U1s7cj5g1PvxscA/mGOXIu
	 RiKHmyd20j7wA==
Date: Fri, 13 Sep 2024 14:52:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	saravanak@google.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4 0/2] Use functionality of irq_get_trigger_type() and
Message-ID: <172625715411.509783.11630589762256837939.robh@kernel.org>
References: <20240912221605.27089-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912221605.27089-1-vassilisamir@gmail.com>


On Fri, 13 Sep 2024 00:16:03 +0200, Vasileios Amoiridis wrote:
> The series is compile tested.
> 
> Changes in v4:
> 	- Use Elvis operator in patch no.2
> 
> ---
> v3: https://lore.kernel.org/linux-devicetree/20240911160253.37221-1-vassilisamir@gmail.com/
> 
> Changes in v3:
> 	- Fix syntax error in patch no.2
> 
> ---
> v2: https://lore.kernel.org/linux-devicetree/20240904160239.121301-1-vassilisamir@gmail.com/
> 
> Changes in v2:
>         - Split patches to subsystems
>         - Use DEFINE_* helpers to define resources
> 
> ---
> v1: https://lore.kernel.org/all/20240902225534.130383-1-vassilisamir@gmail.com/
> 
> 28/11/2024Vasileios Amoiridis (2):
>   of/irq: Make use of irq_get_trigger_type()
>   of/irq: Use helper to define resources
> 
>  drivers/of/irq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
> --
> 2.25.1
> 
> 
> 

Applied, thanks!


