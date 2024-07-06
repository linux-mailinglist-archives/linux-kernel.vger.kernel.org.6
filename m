Return-Path: <linux-kernel+bounces-243399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B99295C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315441C20F74
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FECC6F2F4;
	Sat,  6 Jul 2024 23:13:08 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DE208BA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307587; cv=none; b=ZYrvd6pJsd//pHJFj04ir8D9OD1E/EPZy20M7/zCTb2kP5c/ac45tSvx6xSmpI8pp92y3tbxnNMrWS5qIcJWqaL2gsYbaNHbwzrhlGILXIzJVuBvO8FP/bMcK8XUoH2faxUhDekrh1kRDCdsdvVQnUCB2PS0+gYL4fWPc31w03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307587; c=relaxed/simple;
	bh=Is/urjQoAePpGrHkra08FRP8w9uIpD0POq3sE5K1A1A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QvW4Pze33xcpDtmlez+2mvUkx2Fdcs84AqetPOdM37mXj5LgJpQmB5UaPPC4LIRHaeF02UEvViYPjw2rJM+ySEzqE5hOFamCAwVZVjOck47ZR8p4FtiGhtwrcK6hd+1oT+2MkEw5LQ7fbrM1QuxYZdtJ+v1/ocburWJUUOcsNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmQ53pPpz4xPh;
	Sun,  7 Jul 2024 09:13:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, jgg@ziepe.ca, ruscur@russell.cc, linux-kernel@vger.kernel.org, tpearson@raptorengineering.com, msuchanek@suse.de, vaibhav@linux.ibm.com
In-Reply-To: <172008854222.784.13666247605789409729.stgit@linux.ibm.com>
References: <172008854222.784.13666247605789409729.stgit@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: Define spapr_tce_table_group_ops only with CONFIG_IOMMU_API
Message-Id: <172030740421.964765.9452921118927851661.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 09:10:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 04 Jul 2024 10:22:37 +0000, Shivaprasad G Bhat wrote:
> The patch fixes the below warning,
> arch/powerpc/platforms/pseries/iommu.c:1824:37: warning: 'spapr_tce_table_group_ops' defined but not used [-Wunused-variable]
> 
> The other error reported by the test robot no longer exists on the top
> of the tree due to later changes on the file.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Define spapr_tce_table_group_ops only with CONFIG_IOMMU_API
      https://git.kernel.org/powerpc/c/af199e6ca29c77fb8fea9a78f18dfb165af37cd7

cheers

