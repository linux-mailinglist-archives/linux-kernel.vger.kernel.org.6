Return-Path: <linux-kernel+bounces-325073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3A975494
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C71C212FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573819AD6E;
	Wed, 11 Sep 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfonS4uG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDD18593F;
	Wed, 11 Sep 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062638; cv=none; b=K0SegHNKIOnQzsP9FKu0nA4Tcn3H/16w5Z1GvxzCnfGNKVRm2vV4BwZe+WFziM883kBj+9o3vmxN+wVeSEbdd4RJe47G+d2rjE1GzW+sRw65sREoMbKikuZRTF/eJK0OEjOqJglisdgsBczLeZI7EY3i5BGU9upARKeEivR4an0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062638; c=relaxed/simple;
	bh=j6g3n6ztpZlP10F3yPeE6CvPv6QkWwHvhtKHzXMVn2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msv26mw3VPGZt5/LvFg2taEAWwUEx0ERejVE96EWq97kf1uumTbQ+36Xl9SqzO7pmVt5cTMT8QU5W6wUXhSG+vkFh5Dh8QNWBhrsGExdct8m1XjCpF9S6UgOPSjFlOFQeU+x0cvVlm4nDsTwRqVMk7ghkyv67CuJsimrabk9tGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfonS4uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C3AC4CEC0;
	Wed, 11 Sep 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062637;
	bh=j6g3n6ztpZlP10F3yPeE6CvPv6QkWwHvhtKHzXMVn2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfonS4uGyBE2rJqMkVBvyBLj+X+lKerJnjvCJKY8IkDlwe9W9ZS501Oa438JkOaee
	 YCiCGL3w+L+Kdc9dUNH/Ts1zRZJQIjxxHLYe9fO6B2j8RhT0/h+VEoAu5h09zAstVa
	 fGqY/jaPWA6yyWUpfa/IKMzg+bKviOLvF+2n6fkp5MevWYlzBAKvp5exyb/BX6Yx0/
	 RWqUOrIaRxk3wqwSji4nm0Ar6A4dQ6Ss3PMJe1P2jURdNB4a0AxNrIkQ4C+D+q7Wq2
	 YYD1sfsn25B9d4fevHJZvGXcAW6VFBxMaSp179AbvUaS9Mj/p84PqQrZxn/srxRx+E
	 o8Jgu4a5r/rkA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1soNkF-000000006D9-3UJt;
	Wed, 11 Sep 2024 15:50:56 +0200
Date: Wed, 11 Sep 2024 15:50:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.12-rc1-2
Message-ID: <ZuGgPxNo6BMryM-c@hovoldconsulting.com>
References: <ZuEz67ehYXIG8AXB@hovoldconsulting.com>
 <2024091114-duplex-grit-f5a7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091114-duplex-grit-f5a7@gregkh>

On Wed, Sep 11, 2024 at 03:24:35PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 11, 2024 at 08:08:43AM +0200, Johan Hovold wrote:
> > The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
> > 
> >   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc1-2
> 
> I've pulled this into my usb-next branch as it's too late for 6.11.

Yes, I assumed so (and referred to 6.12 in the tag and Subject).

Thanks.

Johan

