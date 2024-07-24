Return-Path: <linux-kernel+bounces-261131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F9F93B307
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F31F21BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817E15B99D;
	Wed, 24 Jul 2024 14:46:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35E16C685;
	Wed, 24 Jul 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832372; cv=none; b=ljFW4lbIKJPmi+TdObTf/1s9XW5weyx5IrdwxQU84Mnp1UsnQnFDjTSFllekYwjZNO6f4vLggQYZ7pNM+evmcH3pT/9tOwUnQKx91HJd664eCdWdtN07D4OMONG4S44VQMA+XjZ/htOvXhoqwKrVPO1eI8LX0f3IH9h0BPi/VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832372; c=relaxed/simple;
	bh=4pyrrgXCftvJLcmpcCSCmzz5U3WGjbNHNLYFnxaSzuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaUt7XcnCUYkt5/O3pylF40QxE80CrUr92rru5u+3DzFt12gqKy5kbScZWQH+YChZJdfGgZEWfEx+jlcdz6d/REMoZjpJj8/mV+1BaynJaaWBjgi67tn+K31X1wUMSItaHvhRr+0x3J6tOB+QgJmubeYrnXah5FV1/pNejscgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07B3106F;
	Wed, 24 Jul 2024 07:46:35 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98F23F73F;
	Wed, 24 Jul 2024 07:46:08 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:46:05 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v3 0/5] Add Per-transport SCMI debug statistics
Message-ID: <ZqETrQ49FaqAtl2T@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715133751.2877197-1-luke.parkin@arm.com>

On Mon, Jul 15, 2024 at 02:37:46PM +0100, Luke Parkin wrote:
> This series adds support for tracking Arm SCMI statistics [Patch 2/3]
> A config option to enable this [Patch 2]
> Cleans up a unneeded call to handle_scmi_info [Patch 1]
> In [Patch 4] a selection of new debugfs entries to present these statistics
> Then finally in [Patch 5] enabled writing on the debugfs entries to reset stats
> 
> Based on v6.9, Tested on Arm Juno [1]
> 
> Thanks,
> Luke

Beside the specific patch review comments, I have been just reminded by
ATG that using SCMI stats is a bit ambigous since there are statistics
in the protocol...so please in v4 take care to rename all the
code/commmemts and commit msg to something else ... that could be...
"counters" ? instead of stats...so you will have debug counters available
under transport/counters instead of /stats....etc etc

Thanks,
Cristian


