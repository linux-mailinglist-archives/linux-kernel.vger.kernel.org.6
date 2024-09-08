Return-Path: <linux-kernel+bounces-320258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E2970812
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FB0B2113B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B77170A19;
	Sun,  8 Sep 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TM3qf2Vw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5E16D4E8;
	Sun,  8 Sep 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805168; cv=none; b=TR+DBx3aOZ5M7Hgt6QtLBQdJ2950SmuYHMk6AeuPXBALJlRlDwGUP+Ora9NsAq7GEsK35dufSVIr7xUHvT+SBi+3zdVckGuHzB9SdY8nHGcjUAFwlsap3ARC7VmSee3T21cZttH5EjQwvE8XKmUbvjSi/gttSTbR7eef4in0hbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805168; c=relaxed/simple;
	bh=rhebv5qEbCILl+Ua8dJjRhbjNCOn15e7BKVnDy+sL0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB1uVOyA0TTO4EM4OiNwsMJ/a4bdk1mdFj6uVDWU46WvsjEWKhJWiR2OJ9MpmZYoj+4PUmLzyc9kgoRcDmzYiV7T6r4puUkdvdhTvTFBhmxSJ6HdiOp++ttwVzDfVRhF1IgIrVGzVjoSI83lwCRx33klTstjhxMfLR1j1ctWNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TM3qf2Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936FCC4CEC3;
	Sun,  8 Sep 2024 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725805168;
	bh=rhebv5qEbCILl+Ua8dJjRhbjNCOn15e7BKVnDy+sL0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM3qf2Vw4pm1tbbQhdvAbQCl5flWcAf80ufARCwvmJilGyVbCpB7NGzrzw3baqefe
	 3cmQSrWrvczK6T0kzBd1sUGRm0RYomqXtTIcYAigebx6DKe2VZDqdTNFclm15QITal
	 HndfMfuaD9jrB99n1nX1HniH43JzSYwZ/xjF8bsw=
Date: Sun, 8 Sep 2024 16:19:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-43867: drm/nouveau: prime: fix refcount underflow
Message-ID: <2024090855-bonsai-opt-daaa@gregkh>
References: <2024082157-CVE-2024-43867-0620@gregkh>
 <20240902080114.69287-1-chenjun102@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902080114.69287-1-chenjun102@huawei.com>

On Mon, Sep 02, 2024 at 04:01:14PM +0800, Chen Jun wrote:
> Hi,
> 
> This issue seems to be introduced by 019cbd4a4feb instead of ab9ccb96a6e6.
> Could anyone help check again?

Please ask the maintainers and developers of this change and the
subsystem, they are the best ones to determine that their choice of the
Fixes: line was incorrect.

thanks,
greg k-h

