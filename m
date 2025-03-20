Return-Path: <linux-kernel+bounces-569280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B426CA6A0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA888032B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B12080FD;
	Thu, 20 Mar 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iPrgApJv"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C078374EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457866; cv=none; b=X2/HMmMierq+2TS6THTNzcvtbw5nj+A0tTVl1gHkUDvBnW8hrfWujaU9jXdjzKEm79STHuXoAK6SyYwQ4RqKVa3RlsvbQWjQ6cSc62mGAVSAwEDOq1CyiDafHpJefvAuIyhV9pIKXZIDXBRMbhJNoJ3Tqs0Cb+h42RZgLDFQMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457866; c=relaxed/simple;
	bh=4fCnaEwDdVuANaPWV8E8wssVhSb0sO4zLTQ5tXorUww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGfobJ34H8Bs2Hp1q626FhVfl+WHxZUIFBx+ItHxmU2uCtu/H2ArlvB8Pg0ookqyWShBby5P9ZtB+ahDHbm6rcHx0e3IvRdZ0ne502gh0vN+pdvzi++jQ4zu8COvkhiZSA7paeTfRCfCykvHUxc38yCqSGr18ju4D4mvx7GBqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=iPrgApJv; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 61D3646438;
	Thu, 20 Mar 2025 09:04:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1742457863;
	bh=4fCnaEwDdVuANaPWV8E8wssVhSb0sO4zLTQ5tXorUww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPrgApJvTJ+JJ2oz3k4n8GXddiVmJ0V/FutNJcuajdRNJR6Xr6KjW4KY0YlQouBqo
	 dtu7SW0cBW2nf6l/35ukd5+cTs9L5pudjqr52lI3w/40Fo5L2NTVHOClGWQuQ2Iy4i
	 lmZOHAgmNBwi66CtfWEHJFO3ob6aiWOD8xByS5L1ZvSiAMZ9YxhVOQIYvkauQGqHFC
	 0E5ZmoDTMQXbzgNL3U6hjc2qbCUvtzoTvFtamYnGNk3fa/1H1XLo09pTmsNRSJRNuv
	 Et5CCvuiaLEfvSHhfUzfuTV3orttTZ7gHT4rJvEbh6o+EeORJdDG/JbOc7WfaD36cq
	 H4XUF5ZHf4icA==
Date: Thu, 20 Mar 2025 09:04:22 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.15-rc1
Message-ID: <Z9vMBgv8n8heSrNt@8bytes.org>
References: <20250319022101.1053133-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319022101.1053133-1-baolu.lu@linux.intel.com>

On Wed, Mar 19, 2025 at 10:20:58AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Fix possible circular locking dependency
> 
> Sean Christopherson (2):
>   iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is
>     disabled
>   iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity
>     changes
> 
>  drivers/iommu/intel/iommu.c         |  2 ++
>  drivers/iommu/intel/irq_remapping.c | 42 ++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 15 deletions(-)

Applied, thanks Baolu.

