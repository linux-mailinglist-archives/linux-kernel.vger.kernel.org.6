Return-Path: <linux-kernel+bounces-261107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AF93B2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D52815DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C315ADBC;
	Wed, 24 Jul 2024 14:44:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256115AADB;
	Wed, 24 Jul 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832273; cv=none; b=Lk7UJEUBpjlGf0pwXx4dibiQqHNUOw9KRrG7NsA5gUNmJqu0xmo7MBXqZ4+vBXr4E9HTh6wSSSeNb6WoLipjup40evjtekczvovjsQB3c/u4fwBslfIS0D7BJR/d4e7AaZoOt58eVMQoo8UpRNVh8pHX95yjEKBdig3gOxrEUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832273; c=relaxed/simple;
	bh=2W+X7rReYYHDwotbpEc9K6VqaJNHm7qzM6slsS4Qs3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH0VzPr7w/unaUunMEN91UzNPLsqUXs02ceiwUgJjBTp69qW+Dsycp39HC3Erw928iqVIiCC05kwGiK0Y95tfP6X6jklrYEU9pbR+bJzXF3QTPkJ2tkJ1WPBfueh23YxdyZSBJLFufeKRU2CilICFOyYVdQe9po33WGAxGmopyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3411C68CFE; Wed, 24 Jul 2024 16:44:22 +0200 (CEST)
Date: Wed, 24 Jul 2024 16:44:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Christoph Hellwig <hch@lst.de>,
	Shaun Tancheff <shaun.tancheff@hpe.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [filemap]  9aac777aaf:
 phoronix-test-suite.iozone.1MB.512MB.WritePerformance.mb_s -14.0%
 regression
Message-ID: <20240724144422.GA13505@lst.de>
References: <202407242232.9109947e-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407242232.9109947e-oliver.sang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 24, 2024 at 10:40:33PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -14.0% regression of phoronix-test-suite.iozone.1MB.512MB.WritePerformance.mb_s on:
> 
> 
> commit: 9aac777aaf9459786bc8463e6cbfc7e7e1abd1f9 ("filemap: Convert generic_perform_write() to support large folios")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This is really weird as it shouldn't make a different for file systems
not using large folios.  What file system is this test run with?


