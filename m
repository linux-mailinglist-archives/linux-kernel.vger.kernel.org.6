Return-Path: <linux-kernel+bounces-433581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB59E5A11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF4416C75D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32521D593;
	Thu,  5 Dec 2024 15:43:30 +0000 (UTC)
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E921CA02
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413410; cv=none; b=SCxiyXAIdqm3rsvp73NXrDtgUCL8+pN1u6XrzzsWuC97+ERCifDw5hn0odrMcSrS+re/tiLIVRNEjOYmxnxSeaIctn0iaiNwEEX3OZs3mb3OsqxwbwiNMC+b7b7VSvNEdwGqCIYZlYkJyCoVEw4CQhUwrEEsOOddVbzARPDlBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413410; c=relaxed/simple;
	bh=Ue5yd/c5H8RPgms2kjF8yE9yD/MKtFgpRJntW976xFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnQ5zWuL9dx8YnbQo9Ik7bjd/8MBb2VU38KhYwr4beAXzVWo1QXVKBKkznI1wrAU5MDvZlyQ3LekXEWKjUE/WPgmDi7PKAZ7uo7bw3+odftu0KiUdWrLM/TJKs28gRrxB8nu5tEku8cr/nr/DKgMZJhqK/so/H+3dpK191dSP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvack.org; spf=pass smtp.mailfrom=kvack.org; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvack.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 1A0CD6B01F1; Thu,  5 Dec 2024 10:42:13 -0500 (EST)
Date: Thu, 5 Dec 2024 10:42:13 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
Subject: Re: linux-mm mailing list problems
Message-ID: <20241205154213.GA5247@kvack.org>
References: <20241205085217.2086353-1-david@redhat.com> <dc19ac6a-51ae-406a-85e9-c4acf2ecb80a@redhat.com> <276e4bda-b1ec-4beb-b9f5-1daa6e39c992@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276e4bda-b1ec-4beb-b9f5-1daa6e39c992@suse.cz>
User-Agent: Mutt/1.4.2.2i

On Thu, Dec 05, 2024 at 03:43:54PM +0100, Vlastimil Babka wrote:
> On 12/5/24 13:12, David Hildenbrand wrote:
> > On 05.12.24 09:52, David Hildenbrand wrote:
> >> Sending this via the RH SMTP first, because IT doesn't see any obvious
> >> problems why the mails shouldn't be reaching linux-mm, so let's see if
> >> the problems are gone now. If this doesn't work, I'll resend them
> >> using the known-working gmail SMTP. Sorry already for the noise ...
> > 
> > I talked to RH IT, and it looks like the mails get delivered to 
> > linux-mm@kvack.org just fine, and linux-mm decides to silently drop them.

Messages were being dumped into a spam folder as the upstream spam
filtering service used for kvack.org was incorrectly tagging them as spam.
The folder where these messages were being quarantined in was not the one
being checked for the last few months due to the spam tagging changing
back on September 8th.

> > Does anybody know who maintains linux-mm@kvack.org?

Use owner-linux-mm@kvack.org, which has been in place since the mailing
list was first created.  That is the sender of every mailing list message.

Unfortunately, the issue was not flagged to me until today.  The mailing
list footers that used to let people know about the mailing list contact
info previously had to be removed due to the implementation of DKIM
enforcement.  Even sending emails to majordomo@ per the List-Subscribe:
and List-Unsubscribe: headers would have gotten my attention.

> > I wrote a mail to 
> > mbot@kvack.org, but I am pretty sure that is the wrong address.

mbot@kvack.org is a spam trap.  Do not send emails there unless you want
to be marked as a spam sender.

> AFAIK it's Benjamin, CC'd

It should now be fixed as I have tweaked the spam filtering rules.  The
messages misfiled as spam since September 8th have now been delivered.
I'm shocked that nobody bothered reporting this until now.  Please do not
report mailing list issues to the mailing list.  I simply do not have the
time / energy to scan the thousands of messages that fly by every week.
Cheers,

		-ben
-- 
"Thought is the essence of where you are now."

