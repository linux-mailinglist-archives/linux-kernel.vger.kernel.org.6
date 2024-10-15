Return-Path: <linux-kernel+bounces-365336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992999E0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE5B280E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB481C879E;
	Tue, 15 Oct 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="e7GHw8iU"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893C1C68AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980310; cv=none; b=B7w0pME3I5grjiLjwfO37M9tmb7Dko0jRoyN1Wyrk6+gCMU6hDgHSbmayZ59V6VNIbJhg+1O5jlGwniBHN1ttKpGXh7sPPrqZQYhJ2eMQv0+r2dOiP8DFzIufZdzRP7NrFi13Vy9B7XNEoVDZvnspL7iGF5q0imCxNjjRGI7t8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980310; c=relaxed/simple;
	bh=nfHbvO1IcVF9bicFNj/hF4m7F4P30o3eCLyPRgiKEws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJNyC336KIo2ctsq4yWdHIBzdSyYrvzcAsNBuKngcBJSdOBrqXFcRMp3ae3+uaeXhzE/DRRHmW1xBEm+vr7RhDIFrEZT1YG4dcx/e3dk0ap1z6YBhiiwKdFChKGSL5Ijvc2Dfs+/HZAtUNdP6OfCfmCw/wxUERRLAhx8wS7n0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=e7GHw8iU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7BA2C2A7853;
	Tue, 15 Oct 2024 10:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980307;
	bh=nfHbvO1IcVF9bicFNj/hF4m7F4P30o3eCLyPRgiKEws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7GHw8iUL6gYOLbo/xQ+4PjV9tQlNRmNMz9311Zoj4kATtnB1Hf/r3uV+4J4DSXlL
	 K2f7/HTNp+2E/bhM2bjRFdiAJH0UKpkDZlkrEvP/aqovP5lOjMH0UOKEg5ioHxHgra
	 wVgwFSEZ/tlbFpTmMUq5tYIqZUr8cgg/OsvSLkxVpEtkuBbpo9QL6OaY12teBFPW6m
	 1Mi3Ki6fEhV5xr+9F4z1UQY0D3/fwDFF7x7/JS8H4OYRD8SPL7IcXvhwZAP1qzZWYV
	 drSQbQhl1GIiCxBh/oA8v0HD39RJ5KP7YnT/hHO313iqEawqBCkUxR+dyrM/Y1KqI0
	 z8fTWaj9R/DHg==
Date: Tue, 15 Oct 2024 10:18:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.12-rc
Message-ID: <Zw4lUhuPmbYDPK59@8bytes.org>
References: <20241014013744.102197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014013744.102197-1-baolu.lu@linux.intel.com>

On Mon, Oct 14, 2024 at 09:37:43AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices
> 
>  drivers/iommu/intel/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks Baolu.

