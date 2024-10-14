Return-Path: <linux-kernel+bounces-363276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16899BFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7931C22349
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A813DDDD;
	Mon, 14 Oct 2024 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aDJvNZBw"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F13E47B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886708; cv=none; b=iKl4YRvf9PkigjuAah0zyJPtVj6zvlvf7hTCjyPo/XUY67aeXWWd/5XUKlKTVKE5R7MVomQvJFf825HbBRVqvFaN3WMz5esxeFQN3km22Z6wjff+5Y43o25UjP2Nu8PJs02TxjyRAGX17FydVk6+HDMk8eHOTdKbg7iztL+HLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886708; c=relaxed/simple;
	bh=WPFBesik1yS/3y2UBtOgOeuKj26NDF++H1LJ79C5Mcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta/yhgZ06j7CdBhhiwdB2O1We/RKjqpgayuWmEhnz41mx2oXDWUw1yjntilXbuGLJRltnMRQHlRC9casD2HBUrMeg18phymXle04KIwHxgO/fRZgxsSYVABXBLNV7TolUxso6nTtAFq0fXGps0TId4/AO69zsVV4/sS+X7byOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aDJvNZBw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 02:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728886703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1RsvWw+M2To01jAJQ1aEJw2lgmaT0xTmG24D6PTtOU=;
	b=aDJvNZBwALCObGHmEdMBEbHqMvL/ikjeEuSlpuQPAwkPCX0ptO2BrhrmmdvfdmZbP1KsIf
	KkUU2/FqhmDhMBHHm2hZnTCqcSu4zAs5dAxPYxyf23zKRAYM/NsqZkk3CmO/4mTXoanKEu
	h8s1QilB1RYh5mHS+IGZjl1ivozIQbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <755zxemzuyzcmxo3niz7cxghemrgkiemy2guye6i33qaevnjay@kjwymeki74dp>
References: <20241014102859.53f4774f@canb.auug.org.au>
 <2024101458-tux-unopposed-7960@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101458-tux-unopposed-7960@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 08:17:12AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 14, 2024 at 10:28:59AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the bcachefs tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > ERROR: modpost: "sysfs_delete_link" [fs/bcachefs/bcachefs.ko] undefined!
> > 
> > Caused by commit
> > 
> >   c37fd6772eea ("bcachefs: Fix sysfs warning in fstests generic/730,731")
> > 
> > sysfs_delete_link() is not exported to modules.
> 
> Perhaps sysfs_remove_link() should be used instead?

Yes, I've switched the patch back to that

