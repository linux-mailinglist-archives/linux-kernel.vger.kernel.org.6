Return-Path: <linux-kernel+bounces-529931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4467A42CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0736189860D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A142040BD;
	Mon, 24 Feb 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNHlNlth"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCE1CBE8C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424943; cv=none; b=BksHvPqY2w/Ew7VaTIXR9sCmqBSVJ09S/ZH48P6Gl0vGECYSTHJpB009zQvme9isLt/y1rTPcNRcmFoqBjgr0aVAglqjW6hqdzMJhiTKXmFn13ryNFNlCD0W9O7CBYVS9j/6bF+L5SCPOdeTQ7qK/PstJ9ElIt0lbJAecrjQFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424943; c=relaxed/simple;
	bh=+cYB3TSFRnEOAfyP14hkoXxDId6rvq0Xs7DZyGG6wAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNasNFmsheYzfawSrJ9iZFNgEr2XuSvKq4K6rZruE5pt+Mpq5qhLqNGbY8FVjUJtgmuTKz/slN2jmsOfwcI1A3W782Sr7C+ZPnsptd+R8euQwOxrZh4/9/wVwRBkND5ZeUlkCc/I7iyvD9Zx8gmvyhgi6CZx8jlM/rIv/UDUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=XNHlNlth reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b1yvxtkkrbTAmAaR/As9fhu8dBDmrntuNM8lVqz7X9g=; b=XNHlNlthmvjRbze7T//CnF/L/j
	pBvkeflRvjh6rFYYYFkQF/A/Fphk3Cm0fE2cAlrBrRMKATMwMKeVczISsPxN90sfyWCCKpT0ZhU1X
	MwueyplSCQ1Uh1i+KWPW/rTkDJRfGRzlabkrp18L3pDP2kihfKeyZGVvw6RxsL6DfIzZD/870753k
	CHrE+CCxx31NPwOnfSYFF++gICuct7NV+sbp71W0wbzJsIxpl3OMaI/Bx/FaCl9aEzlnXUzo/WYAp
	yzA/ZhzKAs3ZlTU3BiJMVFBS9DZmEUyCzlgO4gwtvjxZJePeNtuDJNUfJNq1AsXSxdSQCyO3p9Sxi
	Aj+orTcw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tme1v-00000007I3z-1xo3;
	Mon, 24 Feb 2025 19:22:15 +0000
Date: Mon, 24 Feb 2025 11:22:11 -0800
From: Joel Becker <jlbec@evilplan.org>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: update MAINTAINERS
Message-ID: <Z7zG4zdwVISQWEGJ@google.com>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20250224162901.349933-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224162901.349933-1-hch@lst.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 08:28:59AM -0800, Christoph Hellwig wrote:
> Joel will go back to maintain configfs alone on a time permitting basis.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Joel Becker <jlbec@evilplan.org>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5434da7a4889..a78eaaa24a69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5856,7 +5856,6 @@ F:	Documentation/security/snp-tdx-threat-model.rst
>  
>  CONFIGFS
>  M:	Joel Becker <jlbec@evilplan.org>
> -M:	Christoph Hellwig <hch@lst.de>
>  S:	Supported
>  T:	git git://git.infradead.org/users/hch/configfs.git
>  F:	fs/configfs/
> -- 
> 2.45.2
> 

-- 

"Egotist: a person more interested in himself than in me."
         - Ambrose Bierce 

			http://www.jlbec.org/
			jlbec@evilplan.org

