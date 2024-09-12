Return-Path: <linux-kernel+bounces-326752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE0976C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69D2285F70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA21B373C;
	Thu, 12 Sep 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V6j0B477"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B841B2EE5;
	Thu, 12 Sep 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152389; cv=none; b=nMVkyXv7fy+4dyeUulA4iLfwirG2aYdG46Vob5ZfGE59GELwh5XfPSKn6pjh1F1DlYwH9GyLvLJoRKoKfuhAXAnyexaG3BcbF7PBd01/AwN6M9mHzL/WdOupjtENJOSvwsGhP6o1CHkSZC8wDtfGtifgISzHlBNrtBy09PaIcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152389; c=relaxed/simple;
	bh=kd2QyFtBWE8Am6zzCzkHURjNjhHPGCPYplS7xyke9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU95OegKF2XEYNMOsIZaT6msvzzC35pZKZUSHfVE8IFV8Zhks4Vm2zHrjxpXDcjBuCyOG5fda4djKxUNgaQJjKnDFPaQLQjAu2KTGSWywFhuqTqjX9tbdZALvR5WR8M+sUcJYUAQSCa2ewDPxYG6TmZ7rcYIQ3vkY25Bi/psEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V6j0B477; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B788CC4CEC4;
	Thu, 12 Sep 2024 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726152389;
	bh=kd2QyFtBWE8Am6zzCzkHURjNjhHPGCPYplS7xyke9Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6j0B4771yocFJO1+16yJ4FUbwRMaem7bibys3EzVP3WUymJhei0XKrkBAiYgWfDX
	 C7N7q2rjh4Nn8MntZvCIVl8RBQ1lYyPo0hepUmf+mSDKcxMLc8NO/CcWhOoqUD9CFB
	 qhjR9BBGdK+NY+/UvlkDgkSJ31ScZN5z1xZ8yyRY=
Date: Thu, 12 Sep 2024 16:46:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: b1n@b1n.io
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Rename variable apTD0Rings
Message-ID: <2024091209-dyslexic-precision-2d9d@gregkh>
References: <20240912144420.71609-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912144420.71609-1-b1n@b1n.io>

On Thu, Sep 12, 2024 at 10:44:20PM +0800, b1n@b1n.io wrote:
> From: b1n <b1n@b1n.io>
> 
> Rename variable apTD0Rings to ap_td0_rings
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: b1n <b1n@b1n.io>

Sorry, we need a real name here...

