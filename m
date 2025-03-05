Return-Path: <linux-kernel+bounces-547041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB159A50236
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A2516C7A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72024EAA7;
	Wed,  5 Mar 2025 14:33:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB724BC0F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185239; cv=none; b=nICJbxC5GdM/iQgyJ1r6CXToFKNAVCLstYpmabkIL94eN7Ntx6lMRP8KrsPsCLKF1+FhFiV0q9IVNFNR5w9yhXDeRAW+q4EOObxeNBDKgMzq4OxixUgfd1jeMLXwmDopijb8usvmbDRLOpR7coD/uPqBDbqmiZnhWuf60esvPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185239; c=relaxed/simple;
	bh=H5BZ6tWR5hlyCvov/NRwRTliNB0jXbmL6hiQqkO+yxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6fd/RR/4dNIHsI/ecs5+5n2Jj8tglnD1F7WW6KC5lTWIX6JBKosL2XzpK3Gk89qc1JoF6Cx6cxgBQGLq3wlJjw/Wpmfl26nTnHXsqqbdtb9/bRSNaa7oDEv18dWngfzFG4BSNCsM6U88eCsSNlZ7Jmmg9Ta1SQQKMwtN5MXDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 149BC68C7B; Wed,  5 Mar 2025 15:33:54 +0100 (CET)
Date: Wed, 5 Mar 2025 15:33:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250305143353.GB18526@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-3-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-3-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 27, 2025 at 10:25:39PM -0500, John Meneghini wrote:
> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
> the multipath parameter is added and multipath support becomes
> configurable with the core.nvme_multipath parameter.

What's the point of adding yet another confusing option?


