Return-Path: <linux-kernel+bounces-312795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D7969B82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C871284F22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4E1A42B2;
	Tue,  3 Sep 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/SRsrIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA61A0BF4;
	Tue,  3 Sep 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362503; cv=none; b=EYAaPxN/WwDZdIlHi6hsw8Dm1bQfepzWR9QZulrx72S78Dhda5vspz7ecL0bMi5BGIJhl5TXKiwWnh1mWCvi2YQjcRFH7YTzrdfsDscPlVofU+9FUvXdUbYiFz3pYB3vx3eXlhCYo8zbPBtWbMIseRxaV4zdVKyhyYrW9C8A+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362503; c=relaxed/simple;
	bh=4FE56k1UVGjsv95hynE4fUeRYp7Znden7WBX7cfLRK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SA1SLqNRcN8SLuYYrVbP5yLcszeMViiBQbIC2MTg/q+rEcMbxw3NYvHvR34YNS4nUHk6ic2uUsFWJJn9WAt6sNAwQ5QmJwXrA8AeeiJzLTytRhHLWQnySJj5MiBK96NpVXYF8ShVXo/JCeHDBX5jZ9CXf9DDnptjWEfEd+XPW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/SRsrIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BAC4CEC4;
	Tue,  3 Sep 2024 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362503;
	bh=4FE56k1UVGjsv95hynE4fUeRYp7Znden7WBX7cfLRK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=T/SRsrIycJO8yXAjB7vCNpF0WYVy/zDdQ/awA04cqEZd1XkHSUu8x0ypLs7CuXv5m
	 IHBQB349TRqSroeBVlAVm+TBrnsOWTIDl4xxXXqE0czlA/bCwJV7IpzNsy70Dm7ViJ
	 J8R9e5CmUSyF+1zZ1TD4h8DMTDGIREApLSKvmlBLNPo/G4iU4a2yLAtnkl+7ahWM7j
	 28p9FFYMhglh9u0OOSHUJn+ZKof1Tt4pGupXbxXdPJ1+4TX0erE9qKghjvFmz3+aF6
	 8eW3DgM+Vp4j4Nrm/+qum3MO29eg9D4HTp84zUMJoJyQbioEH0/7WVUmejg70z9oj3
	 nUPUaEqvCbBfQ==
Date: Tue, 3 Sep 2024 13:21:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Doug Anderson <dianders@google.com>
cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, 
    bentiss@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
    linus.walleij@linaro.org, hsinyi@google.com, 
    dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Add elan-ekth6a12nay on the basis of
 elan-ekth6915
In-Reply-To: <nycvar.YFH.7.76.2408222059160.12664@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2409031321260.31206@cbobk.fhfr.pm>
References: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com> <CAD=FV=V8ivgWn5krEYzt5C4aiHMMK07mtMVwJaCeSQHG6ZscSg@mail.gmail.com> <nycvar.YFH.7.76.2408222059160.12664@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Jiri Kosina wrote:

> > Jiri / Ben,
> [ ... snip ... ]
> > I think this series is ready for you to merge at your leisure. If
> > there's anything blocking it then please yell. Thanks! :-)
> 
> Hmm, for some reason the only mentions of this series in my inbox are your 
> Reviewed-by: from Jun 10th, but nothing else whatsoever. Seems like some 
> spam filter really didn't like it.
> 
> I will pick it up.

Now in hid.git#for-6.12/elan.

Thanks,

-- 
Jiri Kosina
SUSE Labs


