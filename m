Return-Path: <linux-kernel+bounces-436893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD349E8C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4F41886407
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9280215041;
	Mon,  9 Dec 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HXV5Ag4D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83D21481E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729329; cv=none; b=D6GUO0YZ50s9K8MPNNinCMzThqxm3rzeoVxKJOGs57FNPfEULD9hy2f715LSfYiMUmETVa/nNz1M4mXz8bfGt8LQbqpFVasEA8P7D4UBU7cp8IPNCjdvA+0ojhF8KD/P7i1L2mAZaLg834iAyOH1dnvbjWJDBKPsFlEDRM3Cs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729329; c=relaxed/simple;
	bh=8yQuGZr5g5LOLm7HcB3xbvP8aKqMbRTKwyltS3vGU+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTGrV+ECQhdSZvihzI1K1USWCR0ux3Cc8PrpZp+2rxiO86ptTHePDNlDHGjRniIBGL52OYenDGIAuJ2urTJyFNbqSCXls4tloi+wbRBcbbtWrxHXdkxWfPNnyfhGVKPML4MtWxRCVwSBOwB6vOqN9joTnw+EcngZaMDMKtBO0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HXV5Ag4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAA7C4CED1;
	Mon,  9 Dec 2024 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733729328;
	bh=8yQuGZr5g5LOLm7HcB3xbvP8aKqMbRTKwyltS3vGU+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXV5Ag4Dl2aCyqfYKbGZ9I5N+k1ue7og4w+NE8e51iFrlH/mHEIiSw703d0/7mUzc
	 1t66J/tR70+bGYskCMyDzmAnFh7wqamW6BGcoZC8uX9sUnuC1/186wvKyqZq+0C4NC
	 gJFrnC7Dz3ouXxAa4Cq4KjX/a8Nh5u+z9A6BNNJA=
Date: Mon, 9 Dec 2024 08:28:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?iso-8859-1?Q?Ren=E9?= Nyffenegger <mail@renenyffenegger.ch>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] scripts/tags.sh: Tag timer definitions
Message-ID: <2024120918-campsite-unrated-bb36@gregkh>
References: <20241114195521.3073881-1-costa.shul@redhat.com>
 <CADDUTFz8=dm6jRrbd2RLK1+aDZik_W_-HJPEdND9auRr79h6RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDUTFz8=dm6jRrbd2RLK1+aDZik_W_-HJPEdND9auRr79h6RQ@mail.gmail.com>

On Mon, Dec 09, 2024 at 09:18:14AM +0200, Costa Shulyupin wrote:
> Tag id, defined with DEFINE_TIMER(id, ...)
> and ignore usages of DEFINE_TIMER itself.

I'm sorry, but I don't understand this text, please be more descriptive
as to what you are doing and why.

thanks,

greg k-h

