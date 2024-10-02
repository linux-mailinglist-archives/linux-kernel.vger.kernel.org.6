Return-Path: <linux-kernel+bounces-347480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC898D33F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF7B23D57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB281CFECD;
	Wed,  2 Oct 2024 12:28:20 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD321CF5C2;
	Wed,  2 Oct 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872100; cv=none; b=qzTQ6Ia5oxxyoBW5AZ2CkisiFTQoJ6+IPBpDt0b7ckWFLaCV9X6mLAdo+CWsaOmO0qM3dquxquPckhp6R9JKZ5lF7JIWuGiWiTvrSiaarM+IHAltSd5xA8asp3dBpunkksF9bk09SmeM760sB363/Q8UtnWtF6CeN0qbJ92yEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872100; c=relaxed/simple;
	bh=N4Xur+mLsQZL05de5iZX8IUrV/C8XCPjFOiMcsq41Z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYP3MZxfYJPWfXf8APbYCdKwmc7/eH+lG+WenN1WxPTJGMIVsla6lGtfh/kCnl0kAkJo+v+lwOfbtb+cZIcNF6Rqa4sa8L50lbgcn95m6zOD2pl0j3zbhTZ9SBpLlgB6rf57hw5WivtHllmMxFRo8xpc6ML9etWk9FpupOy/uy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6D29E140379;
	Wed,  2 Oct 2024 12:28:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 4148918;
	Wed,  2 Oct 2024 12:28:05 +0000 (UTC)
Message-ID: <9a8ed16ffc65d587ed2ff2d1e95bd61fdca5cc90.camel@perches.com>
Subject: Re: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc
 headers and empty doc comments
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Patrick Miller
	 <paddymills@proton.me>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,  linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Hridesh MG <hridesh699@gmail.com>
Date: Wed, 02 Oct 2024 05:28:04 -0700
In-Reply-To: <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com>
References: <20241002022749.390836-1-paddymills@proton.me>
	 <20241002022749.390836-2-paddymills@proton.me>
	 <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4148918
X-Rspamd-Server: rspamout01
X-Stat-Signature: f6acg6xz7wbmk5td9pdmnfysiunpognq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18UA09o7oar7CV6RrDKDbvwJwmY2y9qRUY=
X-HE-Tag: 1727872085-985029
X-HE-Meta: U2FsdGVkX1+2+m3I6dIDw6nL/ZDpvYqI6HxhouX0dcR57cjNRvBaj93CB4iwcdWeFbgW9ene5kJkbbus5vtUW5FeVneTSMTISvocWa5nF2+UQDArQBz3QWKA4HhfraeVqjJZCsK8f1AanqB/v5hQ6vxfxRXFRfzTqiSON355bTL+u2TqgmSFMUXVUYrtMtrMS/WyWgEx8K0uecXJdO7QWUGCeA5AuZy8orEWHcFALIpcC638cGEBHS1QHB8GM+ELxM+AgEe1a6awWuXjd8f2pmnbcJJBAXiJe0Vj6er4PUDfaHHWylZErIP4x7lcyLka

On Wed, 2024-10-02 at 13:56 +0200, Miguel Ojeda wrote:
> We already have other checks for Rust files that are shared with other
> languages. Perhaps we can be slightly more clear with "checks for Rust
> files (only)" or "Rust-only checks" or "checks that only apply to Rust
> files"?

I'll get this sorted in the next week or so
and forwarded on.

