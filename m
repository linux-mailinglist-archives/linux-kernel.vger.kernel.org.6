Return-Path: <linux-kernel+bounces-434515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A49E67BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE431619AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BFF1DA632;
	Fri,  6 Dec 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKmzGXUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC463FB9C;
	Fri,  6 Dec 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469350; cv=none; b=R3OPs/NRI27kywVfUYkQ74fvyuQ37eTA9NfzY2kVRi3cxXvD7P1JT8q1vxIIK3cvbz/2K853D6bAGBaNkQhR5eVZ7d6ZDRFN0TOJwIoqjmFMFVjbdMXQw4WVwXAerleTsbkE+poUzW7qSSEVVh/DXnLLEfrAjD/SpP4Zvazj7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469350; c=relaxed/simple;
	bh=prYPwPXELgrfJQR1J2K+iBZ3MQF6HXdE5Hni1neGgi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoeoyeLut51zvqiPhc8HT3BXMbz6CmpfhVCbLiI+K3ytMR2lmksoqfH22jmSB2sqmaGSM8RF4DsumD1cPdP4r1EtdyOADSlrf0Opw+/N3rTfBTrjwGcpnIU5nC6ot7OVQwslUnD4GGs6iVxMdI9wEofkNKRplVqVwM3Z3nQsSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKmzGXUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63668C4CEDE;
	Fri,  6 Dec 2024 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469349;
	bh=prYPwPXELgrfJQR1J2K+iBZ3MQF6HXdE5Hni1neGgi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKmzGXUxp+l2MPDfR2gH7qebOqIqw8rmRX5Xj2kbxZrs9zwzbQyqgA6iHWjxuGE07
	 4mpVBHe8ffl/kNaHa0ePuZfrZ3vkSl/N4GKcdz7Z5djorerqytAR7HGAiMuwLc3VAq
	 QJe9fgQpOgt0YQJ49oci69G0qXEeOpKu1MYLF6axApsqt7hed51BFHWdr432u01TGO
	 qdJhABqTUtdTMglX9iWQYpr5GG4l9/WZfLVYXttHaX3IebRIjhYYk3LTEY3mIbzYy3
	 yK7R68Nhu8Kd+LHIYMKqpwqDVeUjS8jbdiTFksexQW6UTR82l8eSrTKiVQ83D6r6Lg
	 mq67kxmpj/8MA==
Date: Fri, 6 Dec 2024 07:15:44 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Documentation: ioctl-number: Carve out some
 identifiers for use by sample drivers
Message-ID: <20241206071544.GD8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-3-lee@kernel.org>
 <2024120656-tuition-freehand-68f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120656-tuition-freehand-68f9@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 04:25:19PM +0000, Lee Jones wrote:
> > 32 IDs should be plenty (at yet, not too greedy) since a lot of sample
> > drivers will use their own subsystem allocations.
> > 
> > Sample drivers predominately reside in <KERNEL_ROOT>/samples, but there
> > should be no issue with in-place example drivers using them.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 243f1f1b554a..dc4bc0cab69f 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -311,6 +311,7 @@ Code  Seq#    Include File                                           Comments
> >                                                                       <mailto:oe@port.de>
> >  'z'   10-4F  drivers/s390/crypto/zcrypt_api.h                        conflict!
> >  '|'   00-7F  linux/media.h
> > +'|'   80-9F  samples/                                                Any sample and example drivers
> 
> This is fine, but why does the sample driver use "R" as the key instead?

You're right, I need to change that (and the example user app) over
to use this new keyword as well.  Thanks for noticing.

-- 
Lee Jones [李琼斯]

