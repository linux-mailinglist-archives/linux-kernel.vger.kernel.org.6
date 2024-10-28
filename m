Return-Path: <linux-kernel+bounces-385363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7759B3629
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79A51C24A64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241521DFE07;
	Mon, 28 Oct 2024 16:12:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39931DED71;
	Mon, 28 Oct 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131973; cv=none; b=O1auDamT4CSkPxhmFpcmqX7iqiQf68Awv8ysFPJ6I85ZXj76dsZff4AjDzKOd7QJAl8AAFP7FdV1xVShrlxPFpcbD9Uz4PGjRW6gfKo9rofsEiIyNUkLzSwOQuMvGNKMDxm5IQlXhIomewWr6doTB7IB7Cq4+cBDug4NLwoduMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131973; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM1G/GaI/x8munPq75ZFkmCblJCWZm2Luq76Aay4phHeBqhbsKqeS4F9XyaFALgUPeaA495J8l4jbCt0RY1v0D9HZDc/cGG9M0ioBfgA7JFz193zoUFXWycHg11PWkmYGD01Co5e9sPPtoLv87zKbj5MMNppXAY3FFyAFQcJ5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0491668BEB; Mon, 28 Oct 2024 17:12:49 +0100 (CET)
Date: Mon, 28 Oct 2024 17:12:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	hare@suse.de, Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH v2 4/7] block: Handle bio_split() errors in
 bio_submit_split()
Message-ID: <20241028161248.GD28829@lst.de>
References: <20241028152730.3377030-1-john.g.garry@oracle.com> <20241028152730.3377030-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028152730.3377030-5-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


