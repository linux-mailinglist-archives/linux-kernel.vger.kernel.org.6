Return-Path: <linux-kernel+bounces-312538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7369697DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8044D1C23478
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA11C7676;
	Tue,  3 Sep 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="isg8FiZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FC1C766F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353561; cv=none; b=moiiF7M8zXHuxG9eCIldrEmUZe3OcuLVikpV+fRqI5cxOqEpHfdnXQ+tbhtUT5HQrEvy/Xps7+lDXDRAnLxK6BlIvNgze8dl/R3G9vDniLIE376TyO8La1lH1DW+x/DkEMVM+RI0+3EFk9dbyWnZRzhmazOIeOR3Z4Ong9wkEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353561; c=relaxed/simple;
	bh=j/swtDh1kCxxE8yl2/OKXdqAEqGwpCOt/uNYgOpRaQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf5sJs13SFuHUB6q/pzjWC3TzZQE0z8Tfh5HJq89HN0/WMT7GKBi2bNBXdlPMIRovZesi9ODedItAULQKK+Di+AWr/4rBd0HIwGwfyFyjVrjergm9A0ffnRv/uf/XPVU8Qeh38xkzRq7PbUBMRDMMLdqd0Mn6Uc9Hg+l1EgSSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=isg8FiZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42ACC4CEC4;
	Tue,  3 Sep 2024 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725353560;
	bh=j/swtDh1kCxxE8yl2/OKXdqAEqGwpCOt/uNYgOpRaQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isg8FiZ31ud1p+8j3k+4Abe9OjFUDI/fUBQEMUipLRwV4h0GrVenRPxvc1RnPUSE3
	 wd4kXWwa1TYWeVgPr9rA7v/nEkf1qO8MOY0Yn2mbESGbnvLGh6dUVUz6FPYjvtEKM5
	 zd1g4+L4rucZqG531NjFTO9MRremes5+i5v9wW5M=
Date: Tue, 3 Sep 2024 10:52:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	bajing <bajing@cmss.chinamobile.com>
Subject: Re: [PATCH v3] binder: modify the comment for binder_proc_unlock
Message-ID: <2024090325-groin-autism-08ac@gregkh>
References: <20240902175446.3757185-1-cmllamas@google.com>
 <20240902175810.3758196-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902175810.3758196-1-cmllamas@google.com>

On Mon, Sep 02, 2024 at 05:58:09PM +0000, Carlos Llamas wrote:
> From: bajing <bajing@cmss.chinamobile.com>
> 
> Modify the comment for binder_proc_unlock() to clearly indicate which
> spinlock it releases and to better match the acquire comment block in
> binder_proc_lock().
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>

Sorry, but this needs to be a full name, not just an email alias.

thanks,

greg k-h

