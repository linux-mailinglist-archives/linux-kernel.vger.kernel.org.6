Return-Path: <linux-kernel+bounces-560838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15475A60A04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F03D3B5CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA871632E4;
	Fri, 14 Mar 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbTj+Sj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CB156C5E;
	Fri, 14 Mar 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937043; cv=none; b=UvsBkVCH0Glr4Ksca4XiAeBD5ib+gUqS2QlhgcXNjZJQ2vVleOTUgfUHq80mcauCdNZqUG9ekhcRXv7rnIhescGjjNknLvrP2JgW2AFVpihF3RXViOdiwl44FXMQbSEEiLwwZyEoH9etJxH0omXLrStc9WTG+hBXYuLuPQqqSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937043; c=relaxed/simple;
	bh=+IwEF8lLXepeDwUxKcxPtgh4rrzcatTlJEwNt/TCBjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cORG4SKEf+LpdlU0ORTmWYv4nqwJtmicfVTLBGKVU4YX+3zG9O/6m3aPmFOfzUf36cwgiqg34WOYe/p1DaYwg5f09AeLt2e+DDRJA7z8Ufkp27gXby7aRkshFzVCBsZMwEYiI3f2rF7ry9IV+XWdalbhXw3Q3oVLCI2ozMT0qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbTj+Sj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F898C4CEE3;
	Fri, 14 Mar 2025 07:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741937043;
	bh=+IwEF8lLXepeDwUxKcxPtgh4rrzcatTlJEwNt/TCBjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbTj+Sj1LnUGkbeUjACTq4N1xsd5PUOkjdtviHcp/z+eMrJxyYdg8XCVI4yxC0g27
	 EcUnzboytxNuTcaZsC37/yoznqtEeyes8lxKpKiSeWxbe47pCR9g9ZdKB3YH/lJpCg
	 Kz/RF29KgoP1TIP596ij6OMk5wNb/HlfV11I5ZbctNtaf518ShdEke+OiyHcxJ15CL
	 6zMTQWsTvgd+WiHU7jsRt4phQWtOBJO3hn06U/S7j0Ca5RzJgxa1k5KN4cuq0Heo9k
	 X++6SKeIgjTBBkFcBxxT2i2owFhgN49gOZmiBkCx2yDLb7obKIOy6jsNqkTLjkjNaC
	 AOgPWti2THgDA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tszOj-000000001eH-26bz;
	Fri, 14 Mar 2025 08:24:01 +0100
Date: Fri, 14 Mar 2025 08:24:01 +0100
From: Johan Hovold <johan@kernel.org>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@altera.com>
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z9PZkX12YX1sbvSt@hovoldconsulting.com>
References: <20250312030544.4967-1-boon.khai.ng@intel.com>
 <Z9G8-66NI_5TLSY-@hovoldconsulting.com>
 <BN8PR03MB507362B42C47E2D3FF7C2D7CB4D22@BN8PR03MB5073.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR03MB507362B42C47E2D3FF7C2D7CB4D22@BN8PR03MB5073.namprd03.prod.outlook.com>

On Fri, Mar 14, 2025 at 02:14:47AM +0000, Ng, Boon Khai wrote:
> > Thanks for the update, now applied.
> > 
> > Next time, remember to put your SoB above the (first) cut-off line (---) so that
> > it is included in the commit message when your patch is applied.
> > I fixed that up manually this time.
> 
> Thank you for your feedback and for applying the update.
> I apologize for the misunderstanding regarding the placement of the SoB. 
> I mistakenly thought I needed to create the cut-off line myself in the 
> commit message. 

No worries.

> I now understand that I should generate the patch first and then
> manually add the change log under the first cut-off line that
> appears below the sign-off.

That's what I do, but if you add your SoB followed by a cut-off line and
change log to your local commit, then that should also work if you later
run git-format-patch.

Johan

