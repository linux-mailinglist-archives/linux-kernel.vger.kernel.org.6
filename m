Return-Path: <linux-kernel+bounces-331322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996C97AB49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19C61F23022
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DDA4D599;
	Tue, 17 Sep 2024 06:12:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62E1B5AA;
	Tue, 17 Sep 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553553; cv=none; b=bkxR9OWYZ+dLPTJKab8R/N2xTKc7VdhyCTB339a9Sv2a360iAH3PF0x0iC+1RQU8/1ydxtjZi5QDYB5hx4clRmIpV1cJGrxMlSpovZmZhjTlS+N38SWPiAMfkPitY3Ar4CKc+qnNAepvGq+YezRQhKzKqF4gZ1e8gnJa1Bs19vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553553; c=relaxed/simple;
	bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTUUjtaLqXx3NusMKdfo9j6v6+lN2/T/VtoJl8e/Y7lPEoF4pq2GvOnGB4WXmqoRGn0zxdIPxr3ErW7CxOfZFWCJTGluEIynZAjmGdDq4wrGayVRD0oO2QgnUtjdFhvm+NXxz/DEAzRjMnrJmdYvPSV01w7ary1YfU+xuoLyiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 303AE227ACB; Tue, 17 Sep 2024 08:12:27 +0200 (CEST)
Date: Tue, 17 Sep 2024 08:12:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <20240917061226.GA3839@lst.de>
References: <20240916174139.1182-1-v.shevtsov@maxima.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916174139.1182-1-v.shevtsov@maxima.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


