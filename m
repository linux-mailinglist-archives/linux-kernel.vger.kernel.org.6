Return-Path: <linux-kernel+bounces-406751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B509C6355
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E5D284753
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D8219E5F;
	Tue, 12 Nov 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="dNXO4mUe"
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F62170DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446587; cv=none; b=lbL4NrL3puXJbRrsAIqgaIS6EDO0tqWz+/bCQL0BCbdeN/HdAQdNUIOxyPSvO7d20khm+88uF7b+H3h0NCoPhWst2/j8TYSSfBTkT6Wc9Ya9NmySyXV4+etYjVYP5gci/TIFAslnePBVwzskBgypDXKOBgj0ZE1ycYgjdFljBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446587; c=relaxed/simple;
	bh=dt+W4jwPHmvYsuvWkhV3WWNG0Uz01POlPX8r55tYII0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwN76dk7JCaDzh7IvpnmMxN5jI9XdczBn4TJBAxrn8e/836ZXZ/LPUOIdFy1zYChgq/Y13VH4d3m6LyxhKd9LTUPHHVkmeIxkoo1lrLmd4WugLwBoxiq2dc3wWyQBIFDOJFMe85kBvBbCIgd0tL76uD1gmPGXmGCrzEd3Hu9Bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=dNXO4mUe; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731446577; bh=dt+W4jwPHmvYsuvWkhV3WWNG0Uz01POlPX8r55tYII0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dNXO4mUeVpg5waiRqJdBzpapUzKzNsDIULmYOiuJM0hLDsEnk97UXvrJ5IDiUe/7X
	 bRXniyCOWxBVFvA+kGdLh9UuLa/ZImshpZVXoTSiWwtjajZNZAQF7OBXu+XaQcvWX6
	 moBsta73iwOHYSqHKy1LMCnnagholpIQOqAKroHi+m21Lu/Kb7KtPRVUhKD8lMNshJ
	 abOG0EwPTmu+tKnb6u7dV2mN3vhWeAlPhg3N3J35FJbvCsI/YOvEZlyUP1Q6ne0kEP
	 HvaCLP+5LFfIX2ETZxJQCsytmcGRHnoMg0mNYZF8uC46bgcXILTp1qhTzmts5lVudh
	 3fn3Fi1DCqG3mu0kLYEsjlLpk3VJWrbFtZ97hA0d/GA8LL/B/Y8JTfaQa9H8RohTFd
	 WizV0gqGzQTlG2lAQSBFyt7RLL2cBtbLNJIT3IkJXxYLCZ26PUQNZyBbg5XYha+dEt
	 i/ODnbdjoEWxj70iqfDX6gjxjOWUHIrqUZrKYVeuLuR5TicdgU5GwsCZYTUut3H3Vm
	 kwgYQ6kg0qIc4tdGqdJrLdvyjG1HzcJ4E0Prz/73c3jkEZPhkiPvpwjeOBAE0tT72l
	 K1j5yorNobtpTBzVQPyfyeS1W7QWv8odu+OKUKZk5qhpp2Z7V1rjm6vXGwO9TCq6q+
	 CWSpR/CThevBPoH8Lx/az68A=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 350F418D986;
	Tue, 12 Nov 2024 22:22:57 +0100 (CET)
Message-ID: <2590cecf-e1f9-4af9-8fbb-9b49f5e335c0@ijzerbout.nl>
Date: Tue, 12 Nov 2024 22:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH v5 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
To: Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
 Lu Baolu <baolu.lu@linux.intel.com>, Tian Kevin <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-3-Jingqi.liu@intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20231013135811.73953-3-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 13-10-2023 om 15:58 schreef Jingqi Liu:
> Add a debugfs directory per pair of {device, pasid} if the mappings of
> its page table are created and destroyed by the iommu_map/unmap()
> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
> Create a debugfs file in the directory for users to dump the page
> table corresponding to {device, pasid}. e.g.
> /sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
> For the default domain without pasid, it creates a debugfs file in the
> debugfs device directory for users to dump its page table. e.g.
> /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
>
> When setting a domain to a PASID of device, create a debugfs file in
> the pasid debugfs directory for users to dump the page table of the
> specified pasid. Remove the debugfs device directory of the device
> when releasing a device. e.g.
> /sys/kernel/debug/iommu/intel/0000:00:01.0
>
> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 53 +++++++++++++++++++++++++++++++----
>   drivers/iommu/intel/iommu.c   |  7 +++++
>   drivers/iommu/intel/iommu.h   | 14 +++++++++
>   3 files changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> [...]
> +/* Remove the device pasid debugfs directory. */
> +void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info *dev_pasid)
> +{
> +	debugfs_remove_recursive(dev_pasid->debugfs_dentry);
> +}
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> [...]
> @@ -4710,6 +4713,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>   
>   	domain_detach_iommu(dmar_domain, iommu);
> +	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>   	kfree(dev_pasid);
>   out_tear_down:
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>

So, a call to intel_iommu_debugfs_remove_dev_pasid() was added.
There is a potential problem that dev_pasid can be NULL.
The diff doesn't show the whole context so let me give that here.
Today that piece of the code looks like this

         list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
                 if (curr->dev == dev && curr->pasid == pasid) {
                         list_del(&curr->link_domain);
                         dev_pasid = curr;
                         break;
                 }
         }
         WARN_ON_ONCE(!dev_pasid);
         spin_unlock_irqrestore(&dmar_domain->lock, flags);

         cache_tag_unassign_domain(dmar_domain, dev, pasid);
         domain_detach_iommu(dmar_domain, iommu);
         intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
         kfree(dev_pasid);

The for_each loop can exit without finding an entry.
The WARN_ON_ONCE also suggests that there can be a NULL.
After that the new function is called (see above) and it will
dereference the NULL pointer.

Can you have a closer look?
-- 
Kees Bakker

