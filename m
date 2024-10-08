Return-Path: <linux-kernel+bounces-354560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50C993F56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738D1B22FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74188183CB0;
	Tue,  8 Oct 2024 06:33:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED216BE23
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369202; cv=none; b=MAPTxl0goUcLbd+6W6xEMFciZ7HTvbjrtG7OOlvk5hhXhvKBZn6MS0tzoD+J4bOp6ySLeLPpnlg7yJXGuvcMVHNPLWzQM2i0gwRB8ZyjBDHSuUo+tzdz8xVniZYfgh4gz0gpg86VORCl9+g02WNPaG4gBUYqK2aCM/npQjP5y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369202; c=relaxed/simple;
	bh=+APgwDb3Jk7AK2giGmPtZN1egEQgAGDqOvnQSQ7zIx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7gA/iouHpvJnLVvo73OH4zkpCBle5R/JfyrEUn8AwPreiG9chaSdHW0oPsOeCJePGltAx9eNVy0fAVWjkvepw+xHNj/27AYFPIZhWuHD/dnw1gn+pKkPZsJfhjnPk9O2YZMRqBlp5PVVKwJ5DjqXWe+QinGbjcBSchjt3RR8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E083227A8E; Tue,  8 Oct 2024 08:33:08 +0200 (CEST)
Date: Tue, 8 Oct 2024 08:33:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
	brauner@kernel.org, sfr@canb.auug.org.au
Subject: Re: [linux-next][20241004]BUG: KFENCE: memory corruption in
 xfs_iext_remove+0x288/0x2c8 [xfs]
Message-ID: <20241008063307.GA22312@lst.de>
References: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 07, 2024 at 07:34:18PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
>
> Observing Kfence errors, while running fsstress test on Power PC platform

Is this new or is this the first time you run kfence?  Any chance you
could bisect it?


