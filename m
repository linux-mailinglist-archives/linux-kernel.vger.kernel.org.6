Return-Path: <linux-kernel+bounces-546995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA92A50194
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00CD1895687
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74124888F;
	Wed,  5 Mar 2025 14:16:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A13FB31
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184201; cv=none; b=MJ8RTs8zfkFTf53pYnoKQTPha2k5l+I9v6ayrZLXj/7x0KcJZq/asXxJ4ALF8HCRBOJxhxxBNFAaWu8Q8Z6KTFL8M4rLGrnRlYiMiBHmTEWw/AakMFXvcZEIgevIcWrsdIVTuKMLYhZrGIvrVDy7G8kwnQMiCKjgoL1L0mEH39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184201; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLR2Lz5MHMX1pUjrqz6+QewPY10tBx0dtHD4K/ArfK4UZwMDFO4662+UFOcAaarmCOGslKRRvlurrPiZInfK8bFE/QH1bLE3FVuaIY87wRkiy7M+p1ThFU8PACYjezM5OVTkGAq+twnedOwz41VEpLJxD56sMEuInSm5kvXV6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A25FB68D05; Wed,  5 Mar 2025 15:16:35 +0100 (CET)
Date: Wed, 5 Mar 2025 15:16:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] nvmet-fcloop: remove nport from list on last user
Message-ID: <20250305141635.GB18065@lst.de>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org> <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


