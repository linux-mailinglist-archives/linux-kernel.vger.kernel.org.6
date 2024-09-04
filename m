Return-Path: <linux-kernel+bounces-314171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964FE96AFA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E6D1F24CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BEA59164;
	Wed,  4 Sep 2024 04:11:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0E3D6B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423063; cv=none; b=HNtWQYY6zftRJs6/hW6K+8vIwAxGJI0HwEoP6J1lRI6mkoorJS8tOVuhf5INNynwktG0wiPcC40TE7SbnTaQC4VEyMqRlQMutxW0JIbitm9YiAMUaqd3bby89+936qRDbspXYi05Jf4VDIgABM1mV+wNqgs5/OMZYvxb0GZiksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423063; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5lSqcijqGORqm3sgQva2olR6awGwU3QcLAVW0hTdo6uZdXcZneRbpKJf2qsBB5W0WxAGsw5wAFrSIvgqt3ZFKU0XpSiKswZrO+W4lHN61JJy4R4swtoYk+Y3iLxPhHhNEO/7hJr/b3xJ1aa3abpNNr3rX8sUUuZnFYDopdkSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D06C068AA6; Wed,  4 Sep 2024 06:10:57 +0200 (CEST)
Date: Wed, 4 Sep 2024 06:10:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme-pci: refresh visible attrs after being checked
Message-ID: <20240904041057.GA13313@lst.de>
References: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

