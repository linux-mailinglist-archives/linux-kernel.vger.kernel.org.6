Return-Path: <linux-kernel+bounces-182672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B056C8C8E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45241C215A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DD141991;
	Fri, 17 May 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="m4ar44u0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qqe9lZaj"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0F1A269;
	Fri, 17 May 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715985826; cv=none; b=Pp9PzX5rSHc5Y8bTlP6rKQxQbiI89W+FgkQnSrIWPpnJ2MAV1IJvpX6Lh75dnPj8RFy9uyCHp7mHhEvVU8/84rkZF6Zh86HnDwj5fLkE/61fAdym6mCkH5UqwmB6UPhuD5wVwkINvvgMBd/c/vtfTK0pfv4oMt7Chgz0gq/bdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715985826; c=relaxed/simple;
	bh=C/6DG8QZ29mW+NZyIt25/Dz4OgGRWVwLPr8Q6/fpqnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUXx1n7HoAVyVRc4fV3yMZnGrKvq5gW1fbw1UDcJb7zB6zse+TGt/07sUBQhtuVWkP8ZKgNBltXAlur54NgAVkRkPid7eG9yAS4zVdZz6BOsGvRRYGrWyjFWNNSLnUpGUXZNaBSiURGgW5qpw4G7mn7XKJBV8nhlGjCJCewlzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=m4ar44u0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qqe9lZaj; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id F37A91C00091;
	Fri, 17 May 2024 18:43:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 May 2024 18:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715985821; x=
	1716072221; bh=sNyymYYOnpwLX9FE6wcDoJfmc9JAPoEulgCf2uboo7I=; b=m
	4ar44u0IQ6mN/2/5kjXJg+F63oX6AoeQ0nDOOmxvkCm4/DsI92iv7GTvJmbLMOUx
	dMo1gkb9FXlb4hDdM71nt5ef5lj68eX7afTrgoTdmRkfVgaiXIwuULDQpVUqthV0
	64Yf6G9Aq4b6HXsYdpjgznGfHP6PS0o4ykiOx793DZ/1Bq7UG40o1HQaSdwE8LyE
	mX5SPUfXi2jNJ12OH+Er3b5KzeSNhAOAseA3XhH2bOF2IVNO/A36eAjmx4X82mS/
	/mti/O6iTJX3S10Aqeg+mNZalyidMyqpvZ+8C7rM6cXJzG9ZGRm15WU4nUwabayr
	eC5vI7gPFW/isbEAWmuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715985821; x=
	1716072221; bh=sNyymYYOnpwLX9FE6wcDoJfmc9JAPoEulgCf2uboo7I=; b=Q
	qe9lZajmTpcxwTRr6PsN0jaK1Fw0mzTY9krWo3D04MMUwjHqKFkhcspjSUMSP9oh
	frp3ejaDEIt8Nq0+bEJQ3R9K/OKmf6GCT4fZg7t6LNfLzvzOnngIwELnEhzAaLkW
	+cA2wwdQnbNKoee6CJ6h4EZedUTVqwrjEVZFBsTbNXTS+FBqzfIsGDOAGRhzDkAs
	U3hGXb9Y9SUFQoreuCtme5zqRhEL3rthPct7GTZ/GwhcxEvpwjs1h6h/KvP9McvF
	7I6rsr5ECn7WfwsgbjAMlhHWcOvBBQ1Hix3pRfk5p8TFJkzD8sdT2Fn4d+xUszP9
	3TOnAl7HGqqgks8t75cNw==
X-ME-Sender: <xms:nN1HZib-Cv6sUMQTSOaw5NWXFTHXg2QqHkXAE_ZJsGKkuAhrBF0oqw>
    <xme:nN1HZlZ2ApLhrYGRKA0A1GEwTvm_nlABbYcYEyhm53clYMLAgLtXsKfFdFTEJLEA3
    JHWGgoTMiJlgM4vW1I>
X-ME-Received: <xmr:nN1HZs_-BQQBiP0ZGiDlqTvnIMuhFkNFD7vucSTd46hmjaXu7whilkX9Ng7lbi7inO9tOrICnEekhYtzxkwKtzzzv9HQxWtt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:nN1HZkrkMscc-a7d0x-AEbDl9b-BndxdR7lqeZhaDLnw_Wovh4Gn-Q>
    <xmx:nN1HZtpzQWY5mHsz6aWnHRr2MQUHhBxf5dGnqd8h0UYaEP2vkzPvrg>
    <xmx:nN1HZiTM0rHMKdUrlRrvGQ_OGLNlx8Xi6fQ7_hDmPrLewPuRK_PT2w>
    <xmx:nN1HZtrU9vWphzK8YECDgMdjaS0yt-ziQwnpQitBvoOawZWD_ZrDQQ>
    <xmx:nd1HZs8Lh4ZtLowyLMnD5Yy4Hqmrb1Ah9Z9h0lVxKo9UxtyWucK745V1>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:43:40 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v7 0/3] platform/x86: dell: Implement platform_profile
Date: Fri, 17 May 2024 16:42:33 -0600
Message-ID: <20240517224323.10045-1-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7:
 - Move platform_profile into new dell-pc module
 - Add myself as maintainer of dell-pc
 - Move smbios call and fill functions to dell-smbios-base
 - Check for classes above 30 and return as not supported
 - Rename dell_laptop_check_supported_cmds to
	 dell_smbios_class_is_supported
 - Check for ENXIO and treat as no thermal modes supported
v6:
 - Add ACPI dependency for dell-laptop
 - Add and use helper symbol for checking supported commands
v5:
 - Fix indent in smbios-thermal-ctl comment
 - Remove linux/wmi.h include
 - Add 'select ACPI_PLATFORM_PROFILE' to Dell KConfig
v4:
 - Make thermal_init and thermal_cleanup static
 - Rearrange order of added includes, did not edit current includes
 - Include bits.h
 - Switch comment style
 - Return error if platform_profile registering failed
 - Add thermal calls to call_blacklist
 - Align defines with tabs
 - Correct separation of function and error handling
 - Propagate error codes up
v3:
 - Convert smbios-thermal-ctl docs to multiline comment and wrap
 - Change thermal_mode_bits enum to directly be BIT() values
	- Convert related code to use this
 - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
	- Correct offset for getting current ACC mode, setting offset
		unchanged
 - Check if thermal_handler is allocated before freeing and
	 unregistering platform_profile
v2:
 - Wrap smbios-thermal-ctl comment
 - Return proper error code when invalid state returned
 - Simplify platform_profile_get returns
 - Propogate ENOMEM error

Lyndon Sanche (3):
  platform/x86: dell-smbios: Add helper for checking supported class
  platform/x86: dell-smbios: Move request functions for reuse
  platform/x86: dell-pc: Implement platform_profile

 MAINTAINERS                                  |   6 +
 drivers/platform/x86/dell/Kconfig            |  13 +
 drivers/platform/x86/dell/Makefile           |   1 +
 drivers/platform/x86/dell/dell-laptop.c      |  23 --
 drivers/platform/x86/dell/dell-pc.c          | 310 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |  35 +++
 drivers/platform/x86/dell/dell-smbios.h      |   7 +
 7 files changed, 372 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/dell/dell-pc.c

-- 
2.42.0


