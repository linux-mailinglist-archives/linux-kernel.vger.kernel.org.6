Return-Path: <linux-kernel+bounces-522201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3BA3C74D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E7A18935ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62479215049;
	Wed, 19 Feb 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDn3RV1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCC1E00BE;
	Wed, 19 Feb 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989366; cv=none; b=fwlxxX0mM8zlt82t1jTjmJ0qqkAkuXNxgAOseDW1RKUlezlAfzc+vd9ibUfJEucvNWy5Qi4c6FrYBNnoam992BtBJJifRr3OjOGSK0hcnjGHIfrfkRAtPFgo4IA5YAEeS/wMQ3n7Hoj6fky8XEDu2YNRrMv+6B8c+BbXQEZzxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989366; c=relaxed/simple;
	bh=3cuVV+ZiWEkaHnhK7iDFTiWlorqOZJvAW3TN09roTdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDiBjf2wzXiDR3k5xUwQfRROLIy2LmUqssjzffLadcLhBZImX8klSo959847InyQ0djjWHKCpcSj+uJYLad+5a3KWsYk7qKBt4dm0ynl6o4wDUZYCQvGqtURRdG0yvE6uF7Nsf0ylsiWfF7Zo7Civ/RRq3AUcAw2IIrLS1ozlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDn3RV1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB15CC4CED1;
	Wed, 19 Feb 2025 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989366;
	bh=3cuVV+ZiWEkaHnhK7iDFTiWlorqOZJvAW3TN09roTdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GDn3RV1rg7bo71UO7nn8v0QAJJ9GG4IoUX5eujr7KsThEwyTLK/yAp0AcFjDiiIDq
	 C+RbMwiQaUvTkrpnYhpfiOXpyeqg2ztady7goxVKr5b/nCXaVwDDEgeLbl/9m9i2BQ
	 +bVFWaHB8aT8f4v1Vyw7US2cPjOXoiu8bTScT4icquaGHsU3dh41J+PTu9tZtI4nCv
	 eQ/0zHBVOwRyN12pIPEQNyt6+EXIe5h9VJ46ojpRepF+5sOSn9gWrSLpWgxDqEmFP1
	 fmcRAXFRc8lY+yEb6Thb8tUBwG25PAAutorjLjdHOjSKpLwn/NTSylenugUSQ5jNZ8
	 J4FkKLwSZdL3g==
Message-ID: <f9e01d23e0711c3a3ec17c251277c58ff8aa3657.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Willy Tarreau <w@1wt.eu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, James Bottomley	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Christoph Hellwig	 <hch@infradead.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH	 <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, 	linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 20:22:41 +0200
In-Reply-To: <20250219113331.17f014f4@gandalf.local.home>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
		<Z7SwcnUzjZYfuJ4-@infradead.org>
		<b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
		<2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
		<yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
		<c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
		<20250219153350.GG19203@1wt.eu>
		<e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
		<20250219155617.GH19203@1wt.eu>
		<20250219160723.GB11480@pendragon.ideasonboard.com>
		<20250219161543.GI19203@1wt.eu>
	 <20250219113331.17f014f4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 11:33 -0500, Steven Rostedt wrote:
>=20
> But we should be encouraging the use of:
>=20
> 	scoped_guard(mutex)(&my_mutex) {
> 		/* Do the work needed for for my_mutex */
> 	}
>=20
> Which does work out very well. And the fact that the code guarded by
> the
> mutex is now also indented, it makes it easier to review.

I just discovered this two days working while working on a new
V4L2 driver. They are a gem! Definitely will decorate most of
lock use with them for the RFC patch set.

Don't need must pitch with those tbh...

>=20
> -- Steve
>=20

BR, Jarkko


