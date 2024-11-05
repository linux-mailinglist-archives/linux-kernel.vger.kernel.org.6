Return-Path: <linux-kernel+bounces-396693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC79BD0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FF11C21243
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514966F307;
	Tue,  5 Nov 2024 15:34:30 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2877102
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820870; cv=none; b=iF2/tiu7ujKiThs2CPElDtXHu8y7BnhZ7pmKDK29RC2KKxA5kYbawrWdPUlvgYd35OC4eyxFAKyGhOwFaP9YT80VLOTxGjhCmtFmqSlGh/mNg4oKu90obYQ60cXaRp0d9kx7lOlJo45OKkacAMFSR4ukv4isCTP8p8oSd5iUwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820870; c=relaxed/simple;
	bh=fJPLfI1KFKjqNz8n95qmiW8lDIlrc6VceKfEz7DCPEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVDmZu5PGU/IA9jmSemqyIqIAlB0hgsk2ucXy4XlRRJm+kEHDzQk/zLOqd0SbXIxixEfhtuUh1qJHJuHsU4JCX5wPOQw5UVSzqBgPTYzlhzILbrgVcuZJXJbMg/rj/hcx27BBiBcjY99accUX+HxQLC3JILGoV4zJcGws9q60b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54D39227AAC; Tue,  5 Nov 2024 16:34:23 +0100 (CET)
Date: Tue, 5 Nov 2024 16:34:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test
 variation before object free at line 583.
Message-ID: <20241105153422.GA7132@lst.de>
References: <202411050650.ilIZa8S7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411050650.ilIZa8S7-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 05, 2024 at 06:52:25AM +0800, kernel test robot wrote:
> >> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.

Does anyone know what this warning is supposed to mean?


