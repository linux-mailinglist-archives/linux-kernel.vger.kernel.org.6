Return-Path: <linux-kernel+bounces-230055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B79177DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A411C2282E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629E13C8F5;
	Wed, 26 Jun 2024 05:06:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5828E7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378392; cv=none; b=XPCVoVMEh77LAhWpfu8sUjNAu5opbgkTOzxxGpE/X2ngUblL5Q/uk0gtQd11NygZXcy3BIgRuIIhvjD3T3jsR8QgvW55tfV3jpI90gT6nyvktaOwmYGCRicMolAz0HAmHSmMTQGv9J9d+NBInpbBS4UJQ8EmMhrpahIpX9uVXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378392; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz4Th2TgxoiuaztU7t2mEX4j04CUioMCDCdwe7VcKqFW3ZcW3JkfeHsdhAduajUJ1Bn12QBLQK/YaBz8PwwnZrtlJpKrAYpYCYwa5CTPSGC8j0UDg6jCXPOpDW9bWoLrqBABCnhY0hd5CEMW8jPFHd0FUfhKEtrpmFx/oKUZmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4257268BEB; Wed, 26 Jun 2024 07:06:27 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:06:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240626050627.GB21922@lst.de>
References: <20240625122605.857462-1-jmeneghi@redhat.com> <20240625122605.857462-3-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-3-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

