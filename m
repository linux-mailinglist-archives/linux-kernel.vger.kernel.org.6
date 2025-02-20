Return-Path: <linux-kernel+bounces-524074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B70A3DEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164731675D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72FC1E3772;
	Thu, 20 Feb 2025 15:37:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E710FD;
	Thu, 20 Feb 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065823; cv=none; b=jyXCqY7/nS97gmXBZhimH4maqKWGeH4bUlddGyZw56IdQPSRB0Dbd9MJEkuZcVe8WxqNIGxbrWmzx2fD1/wWtGyASQX++wNsqaUCFxIOHlgp1npSTu0MwELB7Ua8LK1jnUYdsWsRw3FpIpG/W/IBk6ooa6eXYLCt08hjFLzQP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065823; c=relaxed/simple;
	bh=z2gppk/yVVKegxyFjQQkirKnS57iWTZFafbsqOa4Uds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fe1xVdIcM7b64cO1sqy1PAEHhgvbnFqySpRBXlD6FnGiWHOObreY88k26VEt4EHFwNVwO7WxkVm6NEID0BGKHPR4uMisXBD96yvWWbt/fiTaG7RgGp3e1UNY3sOIh3dTuOKsr0fiQbG7PC0IaaODuVngSXmc2MrhTc2D9NlQIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B2C4CED1;
	Thu, 20 Feb 2025 15:37:01 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:37:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220103727.39114d65@gandalf.local.home>
In-Reply-To: <f4a0d359-456d-4b90-bc0f-995d26837623@p183>
References: <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	<2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
	<yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
	<c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
	<20250219153350.GG19203@1wt.eu>
	<e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
	<20250219155617.GH19203@1wt.eu>
	<20250219160723.GB11480@pendragon.ideasonboard.com>
	<20250219161543.GI19203@1wt.eu>
	<20250219113331.17f014f4@gandalf.local.home>
	<f4a0d359-456d-4b90-bc0f-995d26837623@p183>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 09:26:55 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > But we should be encouraging the use of:
> > 
> > 	scoped_guard(mutex)(&my_mutex) {
> > 		/* Do the work needed for for my_mutex */
> > 	}  
> 
> Meh...
> 
> 	with_rcu() {
> 	}
> 
> 	with_mutex(g_mutex) {
> 	}
> 
> 	with_spin_lock(g_lock) {
> 	}
> 
> > Which does work out very well. And the fact that the code guarded by the
> > mutex is now also indented, it makes it easier to review.  
> 
> It only works only for ~1-2 indents then the code flow away :-(

Then perhaps you should start using helper functions ;-)

-- Steve

