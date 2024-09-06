Return-Path: <linux-kernel+bounces-318786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4396F355
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352201F256C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B51CBE84;
	Fri,  6 Sep 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Oy9QaNOD"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B261CBE8C;
	Fri,  6 Sep 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623007; cv=none; b=Gm0Ynacz/JfSEB0JMD8sL0ONYpWKQIvD2xMJWTElkZ2sl1HGmSH0X5lxAIGy3mv7wQK7xtrwz1PXxekEV5vtz7hxUeFqpVH8ijvAZx3t+R1pKB8wi7XzcrAYdEcEJ8pHWCvTREe0UIXtARYxPEPcmO4LgulaY3cbTZvwhlo6SU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623007; c=relaxed/simple;
	bh=zMmCRgFI714ablx/Mlc9+/NWX2/zpqZ8+lqWhw4i/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7niLd1WxVP5+jdf5kkKEJSAbF2LP3x2aJEVRTIy86PIHRLwJcTLj59aclHWfo1JpL3T39j9ozZHGIveDUMOXp+FsQVqhwnw9VHp/MJDiM6K+4Va9gXp8GtNrq1sr3qANGD2QISD3LLqZNASMkuHVo6+1s3keGFRaj5lCoJq6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Oy9QaNOD; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5A6361FBFB;
	Fri,  6 Sep 2024 13:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725622997;
	bh=zHtMclKF/ryXLIb1oo9T38iNo/P84poCTmamh3tRO3k=; h=From:To:Subject;
	b=Oy9QaNOD6Pyg9+W5FW/VBPabb2wFRnEq7FACgHXChK6/W3nG7zGOA7TUpb0rqS1bu
	 pUXOv0ZrRLB0ixZLU7oUszsVDguTEmNF0iFOAlmd1GsltJ2LS6nzYmIicosXJi8Swc
	 jZaSllKAk8C7QN7tLo8s8u3l8zkX0fk4O99W7Ea7iEAL217gN5cicVcFpdQojsiHbs
	 gNFk6z68L2USSpod9Ms5ltgCrWVImP1AgCBImNSncONRhaXFBmMQzvl0lrIbiq9yLf
	 PM4LM6K8XbgIFE0CJImR+wC1DQ/q13JivFxiDAtuhFEksT5RjwvBKPB/k+YvS8mkfw
	 oa1aSKx1S+UOQ==
Date: Fri, 6 Sep 2024 13:43:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Aradhya Bhatia <a-bhatia1@ti.com>, max.krummenacher@toradex.com
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 0/4] drm/tidss: Add OLDI bridge support
Message-ID: <20240906114311.GA32916@francesco-nb>
References: <20240716084248.1393666-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716084248.1393666-1-a-bhatia1@ti.com>

+Max

Hello Aradhya,

On Tue, Jul 16, 2024 at 02:12:44PM +0530, Aradhya Bhatia wrote:
> The addition of the 2nd OLDI TX (and a 2nd DSS in AM62Px) creates a need
> for some major changes for a full feature experience.
> 
> 1. The OF graph needs to be updated to accurately show the data flow.
> 2. The tidss and OLDI drivers now need to support the dual-link and the
>    cloned single-link OLDI video signals.
> 3. The drivers also need to support the case where 2 OLDI TXes are
>    connected to 2 different VPs - thereby creating 2 independent streams
>    of single-link OLDI outputs.

Have you considered/tested the use case in which only single link is used?
You do not mention it here and to me this is a relevant use case.

There is a workaround for this (use option 2, cloned, even if nothing is
connected to the second link), but this seems not correct.

We (Max in Cc here) noticed that this specific use case is broken on
your downstream v6.6 TI branch.

Francesco


